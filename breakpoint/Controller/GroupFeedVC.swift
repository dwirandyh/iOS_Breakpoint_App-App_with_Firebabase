//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 28/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit
import core

class GroupFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var sendFeedView: UIView!
    @IBOutlet weak var feedText: InsetTextField!
    @IBOutlet weak var sendButton: UIButton!
    
    var group: Group?
    var groupMessages: [Message] = []
    
    func initGroupData(forGroup group: Group){
        self.group = group
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sendFeedView.bindToKeyboard()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        groupTitleLabel.text = self.group?.title
        DataService.instance.getEmailsFor(group: self.group!) { (emails) in
            if emails.count > 1 {
                self.membersLabel.text = "\(emails[0]) and \(emails.count - 1) others in this group"
            }else {
                self.membersLabel.text = "\(emails[0])"
            }
        }
        
        // Observe anything changes in groups to get new message
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllMessagesFor(desiredGroup: self.group!) { (returnedMessage) in
                self.groupMessages = returnedMessage
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismissDetail()
    }
    
    @IBAction func sendFeed(_ sender: Any) {
        if self.feedText.text != "" {
            self.feedText.isEnabled = false
            self.sendButton.isEnabled = false
            DataService.instance.uploadPost(withMessage: feedText.text!, forUID: AuthService.instance.currentUser!.uid, withGroupKey: self.group?.key) { (isSuccess) in
                if isSuccess {
                    self.feedText.text = ""
                    self.feedText.isEnabled = true
                    self.sendButton.isEnabled = true
                    
                    // scroll to bottom
                    if self.groupMessages.count > 0 {
                        self.tableView.scrollToRow(at: IndexPath(row: self.groupMessages.count - 1, section: 0), at: .none, animated: true)
                    }
                }
            }
        }
    }
}

extension GroupFeedVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groupMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupFeedCell", for: indexPath) as? GroupFeedCell else { return UITableViewCell() }
        
        let message = self.groupMessages[indexPath.row]
        
        DataService.instance.getUsername(forUid: message.senderId) { (email) in
            cell.configureCell(profileImage: UIImage(named: "defaultProfileImage")!, email: email, content: message.content)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
}
