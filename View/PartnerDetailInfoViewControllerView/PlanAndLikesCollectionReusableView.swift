//
//  PlanAndLikesCollectionReusableView.swift
//  AbroadApp
//
//  Created by bumslap on 30/12/2018.
//  Copyright © 2018 고상범. All rights reserved.
//

import UIKit

class PlanAndLikesCollectionReusableView: UICollectionReusableView {
    
    let planLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = ""
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UISetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func UISetUp() {
        addSubview(planLabel)
        
        
        planLabel.fillSuperView(with: 10)
       
    }
}
