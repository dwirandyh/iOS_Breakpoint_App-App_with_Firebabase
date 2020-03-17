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
}
