//
//  MeViewController.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 16/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit
import Firebase

class MeVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.emailLabel.text = Auth.auth().currentUser?.email
    }
    

    @IBAction func signOut(_ sender: Any) {
        let logoutPopup = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        let logoutAction = UIAlertAction(title: "Logout?", style: .destructive) { (buttonTapped) in
            do{
                try Auth.auth().signOut()
                let authVC = self.storyboard?.instantiateViewController(identifier: "AuthVC") as? AuthVC
                self.present(authVC!, animated: true, completion: nil)
            }catch {
                print(error)
            }
        }
        
        logoutPopup.addAction(logoutAction)
        self.present(logoutPopup, animated: true, completion: nil)
    }
}
