//
//  EmptyCommentCollectionViewCell.swift
//  AbroadApp
//
//  Created by 이혜주 on 12/01/2019.
//  Copyright © 2019 고상범. All rights reserved.
//

import UIKit

class EmptyCommentCollectionViewCell: UICollectionViewCell {
    let emptyCommentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "작성된 후기가 없습니다. 후기를 작성해보세요"
        label.layer.cornerRadius = 20
        
        label.backgroundColor = #colorLiteral(red: 0.9763649106, green: 0.9765316844, blue: 0.9763541818, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UISetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func UISetUp() {
        
    }
    
}
