//
//  ChatRoom.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 9. 18..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

struct ChatRoom {
    let chatMembers: [String]
    let roomId: String
    let recentMessage: String
    
    init(members: [String], roomId: String, message: String) {
        self.chatMembers = members
        self.roomId = roomId
        self.recentMessage = message
    }
}
