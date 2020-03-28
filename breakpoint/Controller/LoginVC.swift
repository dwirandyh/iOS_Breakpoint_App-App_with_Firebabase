//
//  LoginVC.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 12/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import UIKit
import core

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailTextField: InsetTextField!
    @IBOutlet weak var passwordTextField: InsetTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func signIn(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        AuthService.instance.loginUser(withEmail: email, andPassword: password) { (success, error) in
            if success {
                self.dismiss(animated: true, completion: nil)
            }else {
                print(String(describing: error?.localizedDescription))
            }
            
            self.registerUser(email: email, password: password)
        }
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func registerUser(email: String, password: String){
        AuthService.instance.registerUser(withEmail: email, andPassword: password) { (isRegisteredSuccess, error) in
            if isRegisteredSuccess {
                AuthService.instance.loginUser(withEmail: email, andPassword: password) { (success, error) in
                    self.dismiss(animated: true, completion: nil)
                }
            } else {
                print(String(describing: error?.localizedDescription))
            }
        }
        
    }
}

extension LoginVC : UITextFieldDelegate {
    
}
