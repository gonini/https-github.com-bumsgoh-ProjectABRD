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
        view.layer.cornerRadius = 10
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.image = nil
        return view
    }()
    
    let onOffImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 7
        view.contentMode = .scaleAspectFit
        view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        view.clipsToBounds = true
        return view
    }()
    
    let memberNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "🇰🇷"
        return label
    }()
    
    let chatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.numberOfLines = 5
        label.font = .systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        UISetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func UISetUp() {
        self.contentView.addSubview(onOffImageView)
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(memberNameLabel)
        self.contentView.addSubview(countryLabel)
        self.contentView.addSubview(chatLabel)
        
        self.profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        self.profileImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8).isActive = true
        self.profileImageView.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.8).isActive = true
        self.profileImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15).isActive = true
        
        
        self.onOffImageView.widthAnchor.constraint(equalToConstant: 14).isActive = true
        self.onOffImageView.heightAnchor.constraint(equalToConstant: 14).isActive = true
        self.onOffImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20).isActive = true
        self.onOffImageView.leadingAnchor.constraint(equalTo: self.profileImageView.trailingAnchor, constant: 20).isActive = true
        
        self.memberNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        self.memberNameLabel.leadingAnchor.constraint(equalTo: self.onOffImageView.trailingAnchor, constant: 10).isActive = true
        self.memberNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        self.memberNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.countryLabel.topAnchor.constraint(equalTo: self.memberNameLabel.bottomAnchor, constant: 5).isActive = true
        self.countryLabel.leadingAnchor.constraint(equalTo: self.onOffImageView.trailingAnchor, constant: 10).isActive = true
        self.countryLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        self.countryLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        self.chatLabel.topAnchor.constraint(equalTo: self.countryLabel.bottomAnchor, constant: 5).isActive = true
        self.chatLabel.leadingAnchor.constraint(equalTo: self.onOffImageView.trailingAnchor, constant: 10).isActive = true
        self.chatLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        self.chatLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10).isActive = true
        
    }
}
