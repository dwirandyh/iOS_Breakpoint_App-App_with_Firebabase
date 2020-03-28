//
//  Group.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 28/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import Foundation

class Group {
    var title: String
    var description: String
    var key: String
    var memberCount: Int
    var members: [String]
    
    init(title: String, description: String, key: String, memberCount: Int, members: [String]) {
        self.title = title
        self.description = description
        self.key = key
        self.memberCount = memberCount
        self.members = members
    }
}
