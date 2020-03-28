//
//  CreateGroupsVC.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 20/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit
import core

class CreateGroupsVC: UIViewController {

    
    @IBOutlet weak var titleTextField: InsetTextField!
    @IBOutlet weak var descriptionTextField: InsetTextField!
    @IBOutlet weak var emailSearchTextField: InsetTextField!
    
    @IBOutlet weak var groupMemberLabel: UILabel!
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!
    
    var emails: [String] = []
    var chosenEmails: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.emailSearchTextField.delegate = self
        self.emailSearchTextField.addTarget(self, action: #selector(self.textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        doneButton.isHidden = true
    }
    
    @objc func textFieldDidChange(){
        if self.emailSearchTextField.text == "" {
            emails = []
            self.tableView.reloadData()
        } else {
            DataService.instance.getEmail(forSearchQuery: self.emailSearchTextField.text!) { (returnedEmails) in
                self.emails = returnedEmails
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveGroup(_ sender: Any) {
        guard let title = titleTextField.text, titleTextField.text != "", let description = descriptionTextField.text, descriptionTextField.text != "" else { return }
        
        DataService.instance.getIds(forUsernames: self.chosenEmails) { (ids) in
            var userIds = ids
            // append logged user to group member
            userIds.append(AuthService.instance.currentUser!.uid)
            
            DataService.instance.createGroup(withTitle: title, andDescription: description, forUserIds: userIds) { (isCreated) in
                if isCreated {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    print("Group could not be created. Please try again.")
                }
            }
        }
    }
}

extension CreateGroupsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserCell else { return }
        let selectedEmail = cell.emailLabel.text!
        if !self.chosenEmails.contains(selectedEmail) {
            self.chosenEmails.append(selectedEmail)
            groupMemberLabel.text = chosenEmails.joined(separator: ", ")
            doneButton.isHidden = false
        } else {
            self.chosenEmails = chosenEmails.filter({ $0 != cell.emailLabel.text! })
            if chosenEmails.count >= 1 {
                groupMemberLabel.text = chosenEmails.joined(separator: ", ")
            } else if chosenEmails.count >= 2 {
                groupMemberLabel.text = "\(chosenEmails.suffix(2).joined(separator: ", ")) and \(chosenEmails.count - 2) others"
            } else {
                groupMemberLabel.text = "add people to your group"
                doneButton.isHidden = true
            }
        }
    }
}

extension CreateGroupsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.emails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell else { return UITableViewCell() }
        let image = UIImage(named: "defaultProfileImage")!
        
        let isSelected: Bool = self.chosenEmails.contains(self.emails[indexPath.row])
        
        cell.configureCell(profileImage: image, email: self.emails[indexPath.row], isSelected: isSelected)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

extension CreateGroupsVC: UITextFieldDelegate {
    
}
