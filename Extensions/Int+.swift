//
//  Int+.swift
//  AbroadApp
//
//  Created by bumslap on 16/01/2019.
//  Copyright © 2019 고상범. All rights reserved.
//

import Foundation

extension Int {
    var toDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR") // 지역에 따라 바꿔줘야함
        dateFormatter.dateFormat = "MM.dd HH:mm"
        let date = Date(timeIntervalSince1970: Double(self)/1000)
        return dateFormatter.string(from: date)
    }
    
    
}
