//
//  PartnerDetailViewCommentCellCollectionViewCell.swift
//  AbroadApp
//
//  Created by bumslap on 31/12/2018.
//  Copyright © 2018 고상범. All rights reserved.
//

import UIKit

class PartnerDetailViewCommentCellCollectionViewCell: UICollectionViewCell {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "hairstyle-4")
        return imageView
    }()
    
    let memberNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.text = "james"
        return label
    }()
    
    
    let commentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.backgroundColor = UIColor.clear
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.text = "2018-12-31 00:53:58.077449+0900 AbroadApp[88900:8526058] [BoringSSL] nw_protocol_boringssl_get_output_frames(1301) [C1.1:2][0x7fbf51d0f630] get output frames failed, state 8196"
        return textView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UISetUp()
    }
    
    override func prepareForReuse() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func UISetUp() {
        addSubview(profileImageView)
        addSubview(memberNameLabel)
        addSubview(commentTextView)
        
        profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        memberNameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 24).isActive = true
        memberNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        
        commentTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        commentTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        commentTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 8).isActive = true
        commentTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true
      
        
        
    }
}
