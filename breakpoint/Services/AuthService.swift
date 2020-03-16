//
//  AuthService.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 16/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import Foundation
import Firebase

typealias CompleteHandler = (_ status: Bool, _ error: Error?) -> ()

class AuthService {
    static let instance = AuthService()
    
    func registerUser(withEmail email: String, andPassword password: String, userCreationComplete: @escaping CompleteHandler){
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            guard let user = authResult?.user else { userCreationComplete(false, error); return }
            
            
            let userData : Dictionary<String, Any> = ["provider": user.providerID, "email": user.email!]
            DataService.instance.createDBUser(uid: user.uid, userData: userData)
            userCreationComplete(true, nil)
        }
    }
    
    func loginUser(withEmail email: String, andPassword password: String, loginComplete: @escaping CompleteHandler){
        Auth.auth().signIn(withEmail: email, password: password) { (authDataResult, error) in
            guard (authDataResult?.user) != nil else { loginComplete(false, error); return }
            
            loginComplete(true, nil)
        }
    }
}
