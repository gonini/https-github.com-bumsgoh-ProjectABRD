//
//  PartnerDetailHeaderReusableView.swift
//  AbroadApp
//
//  Created by bumslap on 30/12/2018.
//  Copyright © 2018 고상범. All rights reserved.
//

import UIKit

class PartnerDetailHeaderReusableView: UICollectionReusableView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "IMG_0596")
        return imageView
    }()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "James"
        label.font = UIFont.boldSystemFont(ofSize: 38)
        label.textColor = UIColor.white
        return label
    }()
    
    let userAgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "(21)"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.white
        return label
    }()
    
    var animator: UIViewPropertyAnimator!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UISetUp()
        visualEffectSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func UISetUp() {
        addSubview(profileImageView)
        addSubview(userNameLabel)
        addSubview(userAgeLabel)
        
        profileImageView.fillSuperView(with: 0)
        userNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        userNameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        userAgeLabel.leadingAnchor.constraint(equalTo: userNameLabel.trailingAnchor, constant: 8).isActive = true
        userAgeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true
        
        
    }
    
    private func visualEffectSetUp() {
        
        animator = UIViewPropertyAnimator(duration: 3.0, curve: .linear) {[weak self] in
            
            guard let self = self else {
                return
            }
            let blurEffect = UIBlurEffect(style: .regular)
            let effectView = UIVisualEffectView(effect: blurEffect)
            effectView.translatesAutoresizingMaskIntoConstraints = false
            
            self.addSubview(effectView)
            
            effectView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            effectView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            effectView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            effectView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
        
        //animator.fractionComplete = 0.5
       
    }
    
}
