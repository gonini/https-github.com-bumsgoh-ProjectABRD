//
//  UserInfo.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 12. 15..
//  Copyright © 2018년 고상범. All rights reserved.
//

import Foundation

class UserInfo {
    
    static var userInfo: UserInformation = UserInformation()
    
    struct UserInformation {
        var email: String
        var password: String
        var userName: String
        var userUuid: String
        var latitude: String
        var longitude: String
        
        init(email: String, password: String, userName: String, userUuid: String) {
            self.email = email
            self.password = password
            self.userName = userName
            self.userUuid = userUuid
            self.latitude = ""
            self.longitude = ""
        }
        
        init() {
            self.email = ""
            self.password = ""
            self.userName = ""
            self.userUuid = ""
            self.latitude = ""
            self.longitude = ""
        }
}


}
