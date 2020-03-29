//
//  GroupViewCell.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 28/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit
import core

class GroupFeedCell: UITableViewCell {

    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
    func configureCell(profileImage: UIImage, email: String, content: String){
        self.profileImage.renderInitial(name: email)
        self.emailLabel.text = email
        self.contentLabel.text = content
    }
}
