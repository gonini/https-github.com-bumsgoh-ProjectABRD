//
//  UIView+Constraint.swift
//  AbroadApp
//
//  Created by bumslap on 30/12/2018.
//  Copyright © 2018 고상범. All rights reserved.
//

import UIKit

extension UIView {
    func fillSuperView(with padding: CGFloat) {
        
        guard let superView = self.superview else {
            
            return
        }
        
        self.leadingAnchor.constraint(equalTo: superView.leadingAnchor, constant: padding).isActive = true
        self.trailingAnchor.constraint(equalTo: superView.trailingAnchor, constant: -padding).isActive = true
        self.topAnchor.constraint(equalTo: superView.topAnchor, constant: padding).isActive = true
        self.bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -padding).isActive = true
    }
    
    func centerSuperView() {
        guard let superView = self.superview else {
            
            return
        }
        
        self.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: superView.centerYAnchor).isActive = true
    }
}
