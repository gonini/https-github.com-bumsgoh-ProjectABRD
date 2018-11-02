//
//  WelcomingViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 11. 2..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class WelcomingViewController: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "tourist")
        imageView.contentMode = .scaleAspectFill
        //imageView.layer.opacity = 0.9
        //imageView.layer.backgroundColor = UIColor.black.cgColor
        return imageView
    }()
    
    let blackview: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "abroadApp"
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.textColor = UIColor.white
        
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 6
        label.textColor = UIColor.white
        
        return label
    }()
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
        
        UIView.animate(withDuration: 3.0, delay: 10.0, options: [UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat], animations: {
            //self.backgroundImageView.alpha = 1.0
            self.backgroundImageView.alpha = 0.0
            self.backgroundImageView.image = #imageLiteral(resourceName: "balloon")
            /*UIView.animate(withDuration: 3.0, delay: 3.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.backgroundImageView.alpha = 1.0
                self.backgroundImageView.image = #imageLiteral(resourceName: "balloon")
                self.backgroundImageView.alpha = 0.0
                }, completion: nil)
            */
            
            
            
            
            
           // self.backgroundImageView.image = #imageLiteral(resourceName: "tourist")
        }, completion: nil)
        
    }
    
    func UISetUp() {
        self.view.addSubview(backgroundImageView)
        
        backgroundImageView.addSubview(blackview)
        blackview.addSubview(titleLabel)
        blackview.addSubview(contentLabel)
        self.backgroundImageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.backgroundImageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.backgroundImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.backgroundImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 68).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.contentLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 17).isActive = true
        self.contentLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //self.contentLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        self.contentLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        self.contentLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        
        self.blackview.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.blackview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.blackview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.blackview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }
}
