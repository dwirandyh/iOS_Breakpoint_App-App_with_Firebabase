//
//  ShadowView.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 12/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class ShadowView : UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        setupView()
    }
    
    func setupView(){
        self.layer.shadowOpacity = 0.75
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.black.cgColor
    }
}
