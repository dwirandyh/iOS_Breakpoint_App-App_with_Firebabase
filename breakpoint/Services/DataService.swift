//
//  DataService.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 12/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import Foundation
import Firebase

let DB_BASE : DatabaseReference = Database.database().reference()

typealias SendCompletionHandler = (_ status: Bool) -> Void
typealias FeedMessageHandler = (_ messages: [Message]) -> Void
typealias EmailCompletionHandler = (_ emails: [String]) -> Void
typealias IdsCompletionHandler = (_ ids: [String]) -> Void
typealias GroupCompletionHandler = (_ groupCreated: Bool) -> Void
typealias AllGroupCompletionHanlder = (_ groupsArray: [Group]) -> Void

class DataService {
    static let instance = DataService()
    
    private var _REF_BASE = DB_BASE
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_GROUPS = DB_BASE.child("groups")
    private var _REF_FEED = DB_BASE.child("feed")
    
    var REF_BASE : DatabaseReference {
        return _REF_BASE
    }
    
    var REF_USERS : DatabaseReference {
        return _REF_USERS
    }
    
    var REF_GROUPS : DatabaseReference {
        return _REF_GROUPS
    }
    
    var REF_FEED : DatabaseReference {
        return _REF_FEED
    }
    
    func createDBUser(uid: String, userData: Dictionary<String, Any>){
        REF_USERS.child(uid).updateChildValues(userData)
    }
    
    func uploadPost(withMessage message: String, forUID uid: String, withGroupKey groupKey: String?, sendComplete: @escaping SendCompletionHandler){
        if groupKey != nil {
            
        } else {
            REF_FEED.childByAutoId().updateChildValues(["content": message, "senderId": uid])
            sendComplete(true)
        }
    }
    
    func getUsername(forUid uid: String, handler: @escaping (_ username: String) -> ()){
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let usersSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for user in usersSnapshot {
                if user.key == uid {
                    handler(user.childSnapshot(forPath: "email").value as! String)
                }
            }
        }
    }
    
    func getAllFeedMessages(handler: @escaping FeedMessageHandler){
        var messageArray : [Message] = []
        REF_FEED.observeSingleEvent(of: .value) { (feedMessageSnapshot) in
            guard let feedMessage = feedMessageSnapshot.children.allObjects as? [DataSnapshot] else { return }
            
            for message in feedMessage {
                let content = message.childSnapshot(forPath: "content").value as! String
                let senderId = message.childSnapshot(forPath: "senderId").value as! String
                let newFeedMessage = Message(content: content, senderId: senderId)
                messageArray.append(newFeedMessage)
            }
            
            handler(messageArray)
        }
    }
    
    func getEmail(forSearchQuery query: String, handler: @escaping EmailCompletionHandler){
        var emailArray: [String] = []
        
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if email.contains(query) && email != Auth.auth().currentUser?.email {
                    emailArray.append(email)
                }
            }
            
            handler(emailArray)
        }
    }
    
    func getIds(forUsernames usernames: [String], handler: @escaping IdsCompletionHandler){
        REF_USERS.observeSingleEvent(of: .value) { (userSnapshot) in
            var idArray: [String] = []
            guard let userSnapshot = userSnapshot.children.allObjects as? [DataSnapshot] else { return }
            for user in userSnapshot {
                let email = user.childSnapshot(forPath: "email").value as! String
                
                if usernames.contains(email){
                    idArray.append(user.key)
                }
            }
            
            handler(idArray)
        }
    }
    
    func createGroup(withTitle title:String, andDescription description: String, forUserIds ids: [String], handler: @escaping GroupCompletionHandler){
        REF_GROUPS.childByAutoId().updateChildValues(["title": title, "description": description, "members": ids])
        handler(true)
    }
    
    func getAllGroups(handler: @escaping AllGroupCompletionHanlder){
        var groupsArray = [Group]()
        REF_GROUPS.observeSingleEvent(of: .value) { (snapshot) in
            guard let groupSnapshot = snapshot.children.allObjects as? [DataSnapshot] else { return }
            for group in groupSnapshot {
                let members = group.childSnapshot(forPath: "members").value as! [String]
                if members.contains(Auth.auth().currentUser!.uid) {
                    let title = group.childSnapshot(forPath: "title").value as! String
                    let description = group.childSnapshot(forPath: "description").value as! String
                    let group = Group(title: title, description: description, key: group.key, memberCount: members.count, members: members)
                    groupsArray.append(group)
                }
            }
            
            handler(groupsArray)
        }
    }
}
