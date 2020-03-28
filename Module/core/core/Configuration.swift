//
//  Configuration.swift
//  core
//
//  Created by Dwi Randy Herdinanto on 28/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import Foundation
import Firebase

public class Configuration{
    public static func configureFirebase(){
        FirebaseApp.configure()
    }
}
