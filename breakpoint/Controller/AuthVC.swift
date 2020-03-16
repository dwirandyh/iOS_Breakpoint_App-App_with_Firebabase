//
//  AuthVC.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 12/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit

class AuthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signInWithEMail(_ sender: Any) {
        let loginVC = storyboard?.instantiateViewController(withIdentifier: "LoginVC")
        self.present(loginVC!, animated: true, completion: nil)
    }
    
    @IBAction func signInWithGoogle(_ sender: Any) {
        
    }
    
    @IBAction func signInWithFacebook(_ sender: Any) {
        
    }
}
