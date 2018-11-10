//
//  PartnerDetailInfoViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 6..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class PartnerDetailInfoViewController: UIViewController {
    
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()

    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImageView: UIImageView = {
        let view = UIImageView()
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 300)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.image = #imageLiteral(resourceName: "IMG_0596")
        return view
    }()
    
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
        return label
    }()
    
    let tripPlanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.text = "독일에서 3일 프랑크푸르트에 숙박예정, 이후에 뮌헨으로 가서 4일동안 구경하고 호프브로이 하우스 관광예정입니다.ddddfasdfsdafsdfsadfsadfdaslkfdsajglkje;raosejflkdclvkmdnfkjsanfkjwaoejfoaisdjflj"
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tapGesture.delegate = self
        self.scrollView.delegate = self
        UISetUp()
        self.view.backgroundColor = UIColor.white
        //self.view.alpha = 0.3
    }
    
    func UISetUp() {
        scrollView.contentSize = view.bounds.size
        
        self.view.addSubview(profileImageView)
        self.view.addSubview(memberNameLabel)
        self.view.addSubview(ageLabel)
        self.view.addSubview(tripPlanLabel)
        self.view.addSubview(scrollView)
        self.view.addGestureRecognizer(tapGesture)
        
        self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        profileImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 48).isActive = true
        //profileImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        //profileImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        profileImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        memberNameLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 32).isActive = true
        memberNameLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 42).isActive = true
        
        ageLabel.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 35).isActive = true
        ageLabel.leadingAnchor.constraint(equalTo: self.memberNameLabel.trailingAnchor, constant: 8).isActive = true
        
        tripPlanLabel.topAnchor.constraint(equalTo: self.ageLabel.bottomAnchor, constant: 32).isActive = true
        tripPlanLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        tripPlanLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 45).isActive = true
        tripPlanLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -45).isActive = true
    }
}

extension PartnerDetailInfoViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
//        dismiss(animated: true, completion: nil)
        return true
    }
}

extension PartnerDetailInfoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll (_ scrollView : UIScrollView) {
        let y = 300 - (scrollView.contentOffset.y + 300)
        let height = min(max(y, 60), 400)
        profileImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
    }
}
