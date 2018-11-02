//
//  myPageTravelView.swift
//  AbroadApp
//
//  Created by 이혜주 on 01/11/2018.
//  Copyright © 2018 고상범. All rights reserved.
//

import UIKit

class myPageTravelView: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX + 20, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - 20, y: rect.midY))
        path.lineWidth = 5.0
        #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).setStroke()
        path.stroke()
        path.close()
    }

}
