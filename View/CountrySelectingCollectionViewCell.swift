//
//  MainAlbumCollectionViewCell.swift
//  EdWithProject4
//
//  Created by 고상범 on 2018. 8. 5..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class CountrySelectingCollectionViewCell: UICollectionViewCell {
    
    let thumbNailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        self.contentView.addSubview(thumbNailImageView)
        self.contentView.addSubview(titleLabel)
        
        //imageView Setting
        //thumbNailImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        thumbNailImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5).isActive = true
        thumbNailImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5).isActive = true
        thumbNailImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        thumbNailImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 40).isActive = true
        
        //thumbNailImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        //thumbNailImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 4).isActive = true
        //thumbNailImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -4).isActive = true
        
        //titleLabel Setting
        titleLabel.topAnchor.constraint(equalTo: self.thumbNailImageView.bottomAnchor, constant: 16).isActive = true
        //titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 4).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
       // self.contentView.layer.masksToBounds = true
    }
}


