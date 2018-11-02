//
//  myPageCurrentTravelView.swift
//  AbroadApp
//
//  Created by 이혜주 on 01/11/2018.
//  Copyright © 2018 고상범. All rights reserved.
//

import UIKit

class myPageCurrentTravelView: UIView {
    
    override func draw(_ rect: CGRect) {
//        let startPath = UIBezierPath()
//        
//        
//        let endPath = UIBezierPath()
        
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX + 20, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - 100, y: rect.midY))
        path.lineWidth = 5.0
        #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1).setStroke()
        path.stroke()
        path.close()
    }

}
