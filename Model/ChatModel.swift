//
//  ChatModel.swift
//  AbroadApp
//
//  Created by bumslap on 31/12/2018.
//  Copyright © 2018 고상범. All rights reserved.
//

import Foundation

struct ChatModel {
    
    var users: [String: Bool]
    var comments: [String: Comment]
    
    struct Comment {
        var uid: String?
        var message: String?
    }
}
