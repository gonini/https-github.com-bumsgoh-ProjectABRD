//
//  SignUpInfosViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 5..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class SignUpInfosViewController: UIViewController {
    let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.text = "어떤 아이디를 원하시나요?"
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.numberOfLines = 2
        label.text = "아이디와 함께 사용할 비밀번호를 입력해주세요"
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let idTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.font = UIFont.boldSystemFont(ofSize: 34)
        textField.placeholder = "아이디를 입력해주세요"
       // textField.textAlignment = .center
        return textField
    }()
    
    let passwordFirstTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.font = UIFont.boldSystemFont(ofSize: 26)
        textField.placeholder = "비밀번호를 입력해주세요"
        // textField.textAlignment = .center
        return textField
    }()
    
    let passwordCheckTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.font = UIFont.boldSystemFont(ofSize: 26)
        textField.placeholder = "한번 더 입력해주세요"
        // textField.textAlignment = .center
        return textField
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationItem.title = "2/3 진행"
        UISetUp()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonClicked(sender:)))
    }
    
    
    @objc func nextButtonClicked(sender: UIBarButtonItem) {
        let vc: CountrySelectingCollectionViewController = CountrySelectingCollectionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func UISetUp() {
        self.view.addSubview(idLabel)
        self.view.addSubview(idTextField)
        
        self.view.addSubview(passwordLabel)
        
        self.view.addSubview(passwordFirstTextField)
        self.view.addSubview(passwordCheckTextField)
        
        self.idLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        self.idLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        
        self.idTextField.topAnchor.constraint(equalTo: self.idLabel.bottomAnchor, constant: 32).isActive = true
        self.idTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 52).isActive = true
        
        self.passwordLabel.topAnchor.constraint(equalTo: self.idTextField.bottomAnchor, constant: 92).isActive = true
        self.passwordLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        self.passwordLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        
        self.passwordFirstTextField.topAnchor.constraint(equalTo: self.passwordLabel.bottomAnchor, constant: 32).isActive = true
        self.passwordFirstTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 52).isActive = true
        
        self.passwordCheckTextField.topAnchor.constraint(equalTo: self.passwordFirstTextField.bottomAnchor, constant: 24).isActive = true
        self.passwordCheckTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 52).isActive = true
        
    }

}

extension SignUpInfosViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
