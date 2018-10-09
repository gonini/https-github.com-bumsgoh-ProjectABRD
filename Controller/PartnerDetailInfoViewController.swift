//
//  PartnerDetailInfoViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 6..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class PartnerDetailInfoViewController: UIViewController {
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.image = #imageLiteral(resourceName: "IMG_0596")
        return view
    }()
    
    let memberNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 42)
        label.text = "고상범"
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "25"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    let tripPlanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.text = "독일에서 3일 프랑크푸르트에 숙박예정, 이후에 뮌헨으로 가서 4일동안 구경하고 호프브로이 하우스 관광예정입니다."
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
        self.view.backgroundColor = UIColor.white
        //self.view.alpha = 0.3
    }
    
    func UISetUp() {
        
        self.view.addSubview(profileImageView)
        self.view.addSubview(memberNameLabel)
        self.view.addSubview(ageLabel)
        self.view.addSubview(tripPlanLabel)
        
        profileImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 48).isActive = true
        //profileImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        //profileImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        profileImageView.layer.cornerRadius = self.view.frame.height / 8
        
        memberNameLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 32).isActive = true
        memberNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 42).isActive = true
        
        ageLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 32).isActive = true
        ageLabel.leadingAnchor.constraint(equalTo: self.memberNameLabel.trailingAnchor, constant: 8).isActive = true
        
        tripPlanLabel.topAnchor.constraint(equalTo: self.ageLabel.bottomAnchor, constant: 32).isActive = true
        tripPlanLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tripPlanLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.9).isActive = true
        
    
        
    }
    

   
}
