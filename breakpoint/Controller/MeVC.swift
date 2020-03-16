//
//  MeViewController.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 16/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class MeVC: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func signOut(_ sender: Any) {
    }
}
