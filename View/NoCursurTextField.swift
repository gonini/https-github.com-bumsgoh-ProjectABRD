//
//  NoCursurTextField.swift
//  AbroadApp
//
//  Created by 이혜주 on 10/11/2018.
//  Copyright © 2018 고상범. All rights reserved.
//

import UIKit

class NoCursurTextField: UITextField {

    override func caretRect(for position: UITextPosition) -> CGRect {
        return CGRect.zero
    }
    
    override func selectionRects(for range: UITextRange) -> [Any] {
        return []
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    
        if action == #selector(copy(_:)) || action == #selector(selectAll(_:)) || action == #selector(paste(_:)) {
    
            return false
        }
    
        return super.canPerformAction(action, withSender: sender)
    }

}
