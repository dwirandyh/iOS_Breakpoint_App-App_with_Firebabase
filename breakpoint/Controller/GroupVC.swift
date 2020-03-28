//
//  SecondViewController.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 12/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit
import core

class GroupVC: UIViewController {

    @IBOutlet weak var groupTableView: UITableView!
    
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.groupTableView.delegate = self
        self.groupTableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DataService.instance.REF_GROUPS.observe(.value) { (snapshot) in
            DataService.instance.getAllGroups { (returnedGroups) in
                self.groups = returnedGroups
                self.groupTableView.reloadData()
            }
        }
    }
}

extension GroupVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.groupTableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupCell else { return UITableViewCell() }
        let group: Group = self.groups[indexPath.row]
        cell.configure(title: group.title, description: group.description, memberCount: group.memberCount)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupFeedVC = storyboard?.instantiateViewController(withIdentifier: "GroupFeedVC") as? GroupFeedVC else { return }
        self.present(groupFeedVC, animated: true, completion: nil)
    }
}

extension GroupVC: UITableViewDelegate {
    
}

