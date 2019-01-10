//
//  ChatBubbleCollectionViewCell.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 9. 19..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class ChatBubbleCollectionViewCell: UICollectionViewCell {
    
    let thumbNailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let chatTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.boldSystemFont(ofSize: 18)
        textView.backgroundColor = UIColor.clear
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.textAlignment = .center
        return textView
    }()
    
    let textBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        UISetUp()
    }
    
    override func prepareForReuse() {
        chatTextView.text = ""
        thumbNailImageView.image = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func UISetUp() {
        self.contentView.addSubview(textBubbleView)
        self.contentView.addSubview(thumbNailImageView)
        self.contentView.addSubview(chatTextView)
        

        //imageView Setting
        thumbNailImageView.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
        thumbNailImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
        thumbNailImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true

        thumbNailImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 8).isActive = true
        
      
        
    }
}
