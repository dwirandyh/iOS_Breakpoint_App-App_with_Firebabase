//
//  UIImage+Extension.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 29/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

public extension UIImageView {
    func renderInitial(name: String){
        let backgroundColors: [UIColor] = [#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1), #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)]
        let selectedBackgroundColor: UIColor = backgroundColors[Int.random(in: 0...backgroundColors.count-1)]
        
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        label.backgroundColor = selectedBackgroundColor
        label.textAlignment = .center
        label.textColor = .white
        let fontSize = self.frame.size.width / 2
        label.font = UIFont.boldSystemFont(ofSize: fontSize)
        label.text = String(name.first!).uppercased()
        
        UIGraphicsBeginImageContext(label.frame.size)
        if let currentContext = UIGraphicsGetCurrentContext() {
            label.layer.render(in: currentContext)
            let initialImage = UIGraphicsGetImageFromCurrentImageContext()
            self.image = initialImage
            self.circleImageView()
        }
    }
    
    func circleImageView(){
        self.layer.cornerRadius = self.frame.width / 2;
        self.layer.masksToBounds = true
    }
}
