//
//  GroupCell.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 27/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var membersLabel: UILabel!
    
    func configure(title: String, description: String, memberCount: Int){
        self.titleLabel.text = title
        self.descriptionLabel.text = description
        self.membersLabel.text = "\(memberCount) members."
    }
}
