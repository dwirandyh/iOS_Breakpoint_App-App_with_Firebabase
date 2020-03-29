//
//  UserCell.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 26/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var checkImage: UIImageView!
    
    var showing: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        if selected {
            if showing == false {
                self.checkImage.isHidden = false
                self.showing = true
            } else {
                self.checkImage.isHidden = true
                self.showing = false
            }
        }
    }
    
    func configureCell(profileImage image: UIImage, email: String, isSelected: Bool){
        self.profileImage.renderInitial(name: email)
        self.emailLabel.text = email
        self.checkImage.isHidden = !isSelected
    }

}
