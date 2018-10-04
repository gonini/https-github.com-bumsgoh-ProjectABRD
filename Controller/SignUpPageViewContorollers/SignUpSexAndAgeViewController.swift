//
//  SignUpSexViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 5..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class SignUpSexAndAgeViewController: UIViewController {
    let sexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.text = "성별이 무엇인가요?"
        label.textColor = UIColor.darkGray
        return label
    }()
    let maleImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "hairstyle-2")
        //view.layer.borderWidth = 1
        //view.layer.cornerRadius = 30
        return view
    }()
    
    let femaleImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = #imageLiteral(resourceName: "hairstyle-3")
        //view.layer.borderWidth = 1
        return view
    }()
    
    let sexStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 30
        view.distribution = .fillEqually
        return view
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 34)
        label.text = "나이가 어떻게 되시나요?"
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let agePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.numberOfRows(inComponent: 4)
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        UISetUp()
    }
    
    func UISetUp() {
        self.view.addSubview(sexLabel)
        self.view.addSubview(sexStackView)
        
        self.sexStackView.addArrangedSubview(femaleImageView)
        self.sexStackView.addArrangedSubview(maleImageView)
        
        self.view.addSubview(ageLabel)
        self.view.addSubview(agePickerView)
        
        
        self.sexLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        self.sexLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        
        self.sexStackView.topAnchor.constraint(equalTo: self.sexLabel.bottomAnchor, constant: 24).isActive = true
        self.sexStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.ageLabel.topAnchor.constraint(equalTo: self.sexStackView.bottomAnchor, constant: 72).isActive = true
        self.ageLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        
        
        self.agePickerView.topAnchor.constraint(equalTo: self.ageLabel.bottomAnchor, constant: 24).isActive = true
        self.agePickerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
        
    }
    
    
    
}
