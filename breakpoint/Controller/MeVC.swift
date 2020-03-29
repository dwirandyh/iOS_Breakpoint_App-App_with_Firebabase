//
//  MeViewController.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 16/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit
import core

class MeVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var userGroups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        guard let email = AuthService.instance.currentUser?.email else { return }
        self.emailLabel.text = email
        self.profileImage.renderInitial(name: email)
        DataService.instance.getUserGroups(uid: AuthService.instance.currentUser!.uid) { (groups) in
            self.userGroups = groups
            self.tableView.reloadData()
        }
    }
    
    
    @IBAction func signOut(_ sender: Any) {
        let logoutPopup = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            AuthService.instance.signOut()
            let authVC = self.storyboard?.instantiateViewController(identifier: "AuthVC") as? AuthVC
            self.present(authVC!, animated: true, completion: nil)
            
        }
        
        logoutPopup.addAction(logoutAction)
        self.present(logoutPopup, animated: true, completion: nil)
    }
}

extension MeVC: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userGroups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else { return UITableViewCell() }
        let group: Group = self.userGroups[indexPath.row]
        cell.configure(title: group.title, description: group.description, memberCount: group.memberCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else { return }
        groupFeedVC.initGroupData(forGroup: self.userGroups[indexPath.row])
        self.presentDetail(groupFeedVC)
    }
}
