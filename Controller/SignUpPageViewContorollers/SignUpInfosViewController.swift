//
//  SignUpInfosViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 5..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

// 회원가입 아이디/비밀번호 화면
class SignUpInfosViewController: UIViewController {
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    let outsideStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()
    
    let idStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()

    let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        return stackView
    }()
    
    let passwordTextFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    let passwordLableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
        return stackView
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "아이디"
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "비밀번호"
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let idTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.font = .systemFont(ofSize: 18)
        textField.placeholder = "사용할 아이디를 입력해주세요"
        textField.borderStyle = .none
        return textField
    }()
    
    let passwordFirstTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.font = .systemFont(ofSize: 18)
        textField.placeholder = "비밀번호를 입력해주세요"
        return textField
    }()
    
    let passwordCheckTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.font = .systemFont(ofSize: 18)
        textField.placeholder = "한번 더 입력해주세요"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.tapGesture.delegate = self
        self.idTextField.delegate = self
        UISetUp()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonClicked(sender:)))
    }

    @objc func nextButtonClicked(sender: UIBarButtonItem) {
        let vc: SignUpSexAndAgeViewController = SignUpSexAndAgeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func UISetUp() {
        let tmpView = UIView()
        
        self.outsideStackView.addArrangedSubview(idStackView)
        self.outsideStackView.addArrangedSubview(passwordStackView)
        
        self.idStackView.addArrangedSubview(self.idLabel)
        self.idStackView.addArrangedSubview(self.idTextField)
        
        self.passwordLableStackView.addArrangedSubview(self.passwordLabel)
        self.passwordLableStackView.addArrangedSubview(tmpView)
        
        self.passwordStackView.addArrangedSubview(self.passwordLableStackView)
        self.passwordStackView.addArrangedSubview(self.passwordTextFieldStackView)
        
        self.passwordTextFieldStackView.addArrangedSubview(self.passwordFirstTextField)
        self.passwordTextFieldStackView.addArrangedSubview(self.passwordCheckTextField)
        
        self.view.addSubview(outsideStackView)
        self.view.addGestureRecognizer(tapGesture)
        
        self.idLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.passwordLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.outsideStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.outsideStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
}

extension SignUpInfosViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("alfskjfdlkjdalksf")
        textField.resignFirstResponder()
        return true
    }
}

extension SignUpInfosViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("alfskjfdlkjdalksf")
        self.view.endEditing(true)
        return true
    }
}
