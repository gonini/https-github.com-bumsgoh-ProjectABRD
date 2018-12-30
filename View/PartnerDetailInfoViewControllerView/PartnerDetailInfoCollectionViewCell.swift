//
//  PartnerDetailInfoCollectionViewCell.swift
//  AbroadApp
//
//  Created by bumslap on 30/12/2018.
//  Copyright © 2018 고상범. All rights reserved.
//

import UIKit

class PartnerDetailInfoCollectionViewCell: UICollectionViewCell {
    
    let memberNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.text = "고상범"
        return label
    }()
        
    let ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.text = "25"
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "🇰🇷"
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    let tripPlanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.text = "독일에서 3일 프랑크푸르트에 숙박예정, 이후에 뮌헨으로 가서 4일동안 구경하고 호프브로이 하우스 관광예정입니다."
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         UISetUp()
    }
    
    
    func UISetUp() {
        titleStackView.addArrangedSubview(memberNameLabel)
        titleStackView.addArrangedSubview(ageLabel)
        //        titleStackView.addArrangedSubview(countryLabel)
        
        self.contentView.addSubview(titleStackView)
        self.contentView.addSubview(tripPlanLabel)
        
        NSLayoutConstraint.activate([
            self.contentView.heightAnchor.constraint(equalToConstant: 250),
            
            titleStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            titleStackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            tripPlanLabel.topAnchor.constraint(equalTo: memberNameLabel.bottomAnchor, constant: 25),
            tripPlanLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            tripPlanLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    


}
