//
//  CreateGroupsVC.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 20/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class CreateGroupsVC: UIViewController {

    @IBOutlet weak var groupTitleLabel: InsetTextField!
    @IBOutlet weak var groupDescriptionLabel: InsetTextField!
    @IBOutlet weak var emailLabel: InsetTextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveGroup(_ sender: Any) {
        
    }
    
}
