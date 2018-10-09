//
//  PartnersTableViewCell.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 6..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class PartnersTableViewCell: UITableViewCell {
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.image = #imageLiteral(resourceName: "IMG_0596")
        return view
    }()
    
    let memberNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    let chatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "BBQ Fried Chicken is amazing!"
        return label
    }()
    
    
   
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        UISetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func UISetUp() {
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(memberNameLabel)
        self.contentView.addSubview(chatLabel)
        
        self.profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.profileImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        
        
        self.memberNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        self.memberNameLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 16).isActive = true
        
        self.chatLabel.topAnchor.constraint(equalTo: self.memberNameLabel.bottomAnchor, constant: 8).isActive = true
        self.chatLabel.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 16).isActive = true
        
        
        
        
        
    }
    

}
