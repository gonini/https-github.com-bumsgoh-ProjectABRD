//
//  ChatUserModel.swift
//  AbroadApp
//
//  Created by bumslap on 31/12/2018.
//  Copyright © 2018 고상범. All rights reserved.
//

import Foundation

struct ChatModel {
    
    var users: [String: Bool]
    var comments: [String: [String: String]]
    var profileImageUrl: String
    var userName: String
    var uid: String
    
     struct Comment {
        public var uid : String?
        public var message : String?
       // public var timestamp :Int?
       // public var readUsers : [String: Bool] = [:]
    }
    
    init(users: [String: Bool], comments: [String: [String: String]], url: String, name: String, uid: String) {
        
        self.users = users
        self.comments = comments
        self.profileImageUrl = url
        self.uid = uid
        self.userName = name
    }
}
