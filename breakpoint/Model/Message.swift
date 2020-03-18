//
//  Message.swift
//  breakpoint
//
//  Created by Dwi Randy Herdinanto on 18/03/20.
//  Copyright © 2020 dwirandyh.com. All rights reserved.
//

import Foundation

class Message {
    private var _content: String
    private var _senderId: String
    
    var content: String {
        return _content
    }
    
    var senderId: String {
        return _senderId
    }
    
    init(content:String, senderId: String) {
        self._content = content
        self._senderId = senderId
    }
}
