//
//  WelcomingViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 11. 2..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class WelcomingViewController: UIViewController {
    
    var timer = Timer()
    var photoCount:Int = 0
    let images: [UIImage] = [#imageLiteral(resourceName: "rough"),#imageLiteral(resourceName: "person"),#imageLiteral(resourceName: "tourist")]
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "balloon")
        imageView.contentMode = .scaleAspectFill
        //imageView.layer.opacity = 0.9
        //imageView.layer.backgroundColor = UIColor.black.cgColor
        return imageView
    }()
    
    let blackview: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
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
    
    lazy var signUpLabel: UIButton = {
        let label = UIButton()
        label.translatesAutoresizingMaskIntoConstraints = false
//label.text = "you don't have an account yet?"
        
        label.setTitle("you don't have an account yet?", for: UIControlState.normal)
       // label.isUserInteractionEnabled = true
        label.setTitleColor(UIColor.white, for: UIControlState.normal)
        label.addTarget(self, action: #selector(signUpClicked), for: UIControlEvents.touchUpInside)
        //textColor = UIColor.white
        
        return label
    }()
    
   
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    override func viewDidAppear(_ animated: Bool) {
        
       
        backgroundImageView.image = UIImage.init(named: "balloon")
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(onTransition), userInfo: nil, repeats: true)
    
        
            
            }
  
    @objc func onTransition() {
    if (photoCount < images.count - 1){
        photoCount = photoCount  + 1;
    }else{
        photoCount = 0;
    }
        //OperationQueue.main.addOperation {
          
        
        UIView.transition(with: self.backgroundImageView, duration: 5.0, options: [UIViewAnimationOptions.transitionCrossDissolve, UIViewAnimationOptions.allowUserInteraction], animations: {
       // self.backgroundImageView.transform = CGAffineTransform(translationX: -30, y: 0)
           //self.backgroundImageView.alpha = 0.1
        self.backgroundImageView.image = self.images[self.photoCount]
    }, completion: {(done) in
        //self.backgroundImageView.transform = CGAffineTransform.identity

    })
       // }
}
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
       // self.view.backgroundColor = UIColor.black
        //backgroundImageView.backgroundColor =
        //backgroundImageView.alpha = 0.8
       // titleLabel.alpha = 1
        
        
        
    }
   
    func randomImage() -> UIImage {
        let ranValue: Int = Int.random(in: 0...2)
        print(ranValue)
        return self.images[ranValue]
    }
    func UISetUp() {
        self.view.addSubview(backgroundImageView)
        
        self.backgroundImageView.addSubview(blackview)
        blackview.addSubview(titleLabel)
        blackview.addSubview(contentLabel)
        backgroundImageView.addSubview(signUpLabel)
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
        self.blackview.leadingAnchor.constraint(equalTo: self.backgroundImageView.leadingAnchor,constant: -30).isActive = true
        self.blackview.trailingAnchor.constraint(equalTo: self.backgroundImageView.trailingAnchor, constant: 30).isActive = true
        
        self.signUpLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.signUpLabel.bottomAnchor.constraint(equalTo: self.blackview.bottomAnchor, constant: -32).isActive = true
       // signUpLabel.addGestureRecognizer(recognizer)
    }
    
   @objc func signUpClicked() {
        print("clicked!!!")
    }
}/*
extension UIImageView{
    
    func transition(toImage: UIImage, withDuration duration: TimeInterval){
       
        //UIView.setAnimationRepeatCount(10)
        
        UIView.animate(withDuration: duration, delay: 0, options: [UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat],animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(translationX: -30, y: 0)
            self.animationImag
            self.transform = CGAffineTransform.identity
            self.image = toImage
            self.alpha = 1
        }) { (bool) in
            
            UIView.animate(withDuration: duration, animations: {
               
                
            }, completion: {
                (_) in
                
            })
        }
        //self.image = #imageLiteral(resourceName: "balloon")
    }
}*/
