//
//  GroupFeedVC.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 28/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class GroupFeedVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    @IBOutlet weak var sendFeedView: UIView!
    @IBOutlet weak var feedText: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendFeed(_ sender: Any) {
        
    }
}
