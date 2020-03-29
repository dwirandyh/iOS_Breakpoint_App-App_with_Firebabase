//
//  UIViewController+Extenstion.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 29/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentDetail(_ targetedViewController: UIViewController){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        self.present(targetedViewController, animated: false, completion: nil)
    }
    
    func dismissDetail(){
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        self.dismiss(animated: false, completion: nil)
    }
}
