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
    
    let writeCommentTextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Write Comment", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19)
        return button
    }()
    
    lazy var writeCommentButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        return button
    }()
    
    let coverView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UISetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func UISetUp() {
        self.isUserInteractionEnabled = true
        addSubview(coverView)
        coverView.addSubview(planLabel)
        coverView.addSubview(writeCommentButton)
        coverView.addSubview(writeCommentTextButton)
        
        coverView.fillSuperView(with: 10)

        planLabel.topAnchor.constraint(equalTo: coverView.topAnchor).isActive = true
        planLabel.leadingAnchor.constraint(equalTo: coverView.leadingAnchor, constant: 5).isActive = true
        planLabel.trailingAnchor.constraint(equalTo: coverView.trailingAnchor, constant: -5).isActive = true
        planLabel.bottomAnchor.constraint(equalTo: writeCommentButton.topAnchor, constant: -30).isActive = true
        
        writeCommentButton.topAnchor.constraint(equalTo: planLabel.bottomAnchor, constant: 25).isActive = true
        writeCommentButton.trailingAnchor.constraint(equalTo: coverView.trailingAnchor, constant: -12).isActive = true
        writeCommentButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        writeCommentButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        writeCommentTextButton.centerYAnchor.constraint(equalTo: writeCommentButton.centerYAnchor).isActive = true
        writeCommentTextButton.topAnchor.constraint(equalTo: planLabel.bottomAnchor, constant: 25).isActive = true
        writeCommentTextButton.trailingAnchor.constraint(equalTo: writeCommentButton.leadingAnchor, constant: -10).isActive = true

    }
    
}
