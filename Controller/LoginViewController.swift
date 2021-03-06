//
//  LoginViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 4..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase
import Firebase

import CoreLocation

// 로그인 화면
class LoginViewController: UIViewController {

    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    let loginIdTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.placeholder = "아이디를 입력해주세요"
        textField.textAlignment = .center
        textField.textContentType = .emailAddress
        textField.autocapitalizationType = .none
        textField.clearButtonMode = .always
        return textField
    }()
    
    let loginPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.isSecureTextEntry = true
        textField.textAlignment = .center
        textField.clearButtonMode = .always
        return textField
    }()
    
    let idTextFieldDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    
    let passwordTextFieldDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    
    lazy var loginButton: UIButton = {[weak self] in
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Get Started", for: UIControl.State.normal)
        button.setTitleColor(#colorLiteral(red: 0.0919258669, green: 0.5034434199, blue: 0.9811272025, alpha: 1), for: UIControl.State.normal)
        
        button.addTarget(self, action: #selector(loginButtonClicked(sender:)), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    lazy var signUpTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor.darkGray
        label.text = "아직 회원이 아니신가요?"
        label.isUserInteractionEnabled = true
        return label
    }()
    
    let appTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 54)
        label.text = "Log in"
        label.textColor = UIColor.darkGray
        return label
    }()
    
    lazy var signUpGestureRecognizer: UITapGestureRecognizer = {[weak self] in
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(signUpButtonClicked(sender:)))
        return recognizer
    }()
    
    lazy var indicatorView: LoadingIndicatorView = {
        let view = LoadingIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.noticeLabel.text = ""
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        self.loginIdTextField.delegate = self
        self.loginPasswordTextField.delegate = self
        self.tapGesture.delegate = self
        UISetUp()
        self.signUpTextLabel.addGestureRecognizer(signUpGestureRecognizer)
    }

    @objc func loginButtonClicked(sender: UIButton) {
        indicatorView.activateIndicatorView()
        sender.isEnabled = false
        guard let email = loginIdTextField.text, let password = loginPasswordTextField.text else {
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] (user, error) in
            if let error = error {
                let alertController = UIAlertController(title: "알림", message: "아이디 혹은 비밀번호를 확인해주세요", preferredStyle: .alert)
                let okButton = UIAlertAction(title: "확인", style: .cancel, handler: nil)
                alertController.addAction(okButton)
                
                DispatchQueue.main.async {
                    self?.present(alertController, animated: true, completion: nil)
                    self?.indicatorView.deactivateIndicatorView()
                    print(error.localizedDescription)
                    sender.isEnabled = true
                }
                
                return
            }
            
            if let user = user?.user {
                InstanceID.instanceID().instanceID(handler: { [weak self] (result, error) in
                    if let error = error {
                        print("Error fetching remote instange ID: \(error)")
                    } else if let result = result {
                        
                        Database.database().reference().child("users").child(user.uid).updateChildValues(["pushToken": result.token]) {_,_ in
                            
                            DispatchQueue.main.async {
                                sender.isEnabled = true
                                self?.indicatorView.deactivateIndicatorView()
                                let MainPageVC: MainTabBarController = MainTabBarController()
                                let newRootViewController = UINavigationController(rootViewController: MainPageVC)
                                UIApplication.shared.keyWindow?.rootViewController = newRootViewController
                            }
                        }
                    }
                })
 
                }
            
        }
    }
    
    @objc func loginButtonReleased(sender: UIButton) {
       
    }
    
    @objc func signUpButtonClicked(sender: UIButton) {
//        self.navigationController?.isNavigationBarHidden = false
        let signUpPageVC: SignUpInfosViewController = SignUpInfosViewController()
        self.navigationController?.pushViewController(signUpPageVC, animated: true)
    }

    func UISetUp () {
        self.view.addSubview(indicatorView)
        self.view.addSubview(appTitleLabel)
        self.view.addSubview(idTextFieldDivider)
        self.view.addSubview(loginButton)
        self.view.addSubview(loginIdTextField)
        self.view.addSubview(loginPasswordTextField)
        self.view.addSubview(passwordTextFieldDivider)
        self.view.addSubview(signUpTextLabel)
        self.view.addGestureRecognizer(tapGesture)
        
        indicatorView.deactivateIndicatorView()
        indicatorView.widthAnchor.constraint(greaterThanOrEqualToConstant: 180).isActive = true
        indicatorView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.appTitleLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100).isActive = true
        //self.appTitleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //self.appTitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        
        self.appTitleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        /*
        self.logoImageView.topAnchor.constraint(equalTo: self.appTitleLabel.bottomAnchor, constant: 84).isActive = true
        self.logoImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.logoImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        self.logoImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        */
        self.loginIdTextField.topAnchor.constraint(equalTo: self.appTitleLabel.bottomAnchor, constant: 74).isActive = true
        self.loginIdTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        self.loginIdTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.loginIdTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
      //  self.loginIdTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true
        //self.loginIdTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        
        self.idTextFieldDivider.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.idTextFieldDivider.widthAnchor.constraint(equalTo: self.loginIdTextField.widthAnchor).isActive = true
        self.idTextFieldDivider.topAnchor.constraint(equalTo: self.loginIdTextField.bottomAnchor, constant: 3).isActive = true
        //self.idTextFieldDivider.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        //self.textFieldDivider.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.95).isActive = true
       // self.idTextFieldDivider.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
       // self.idTextFieldDivider.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true
        
        self.idTextFieldDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.loginPasswordTextField.topAnchor.constraint(equalTo: self.idTextFieldDivider.bottomAnchor, constant: 24).isActive = true
        self.loginPasswordTextField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        self.loginPasswordTextField.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.loginPasswordTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.passwordTextFieldDivider.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.passwordTextFieldDivider.topAnchor.constraint(equalTo: self.loginPasswordTextField.bottomAnchor).isActive = true
        self.passwordTextFieldDivider.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.6).isActive = true
        self.passwordTextFieldDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.signUpTextLabel.topAnchor.constraint(equalTo: self.passwordTextFieldDivider.bottomAnchor, constant: 16).isActive = true
         self.signUpTextLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64).isActive = true
        
        self.loginButton.topAnchor.constraint(equalTo: self.signUpTextLabel.bottomAnchor, constant: 8).isActive = true
        self.loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -64).isActive = true
        
        /*
        self.loginButton.topAnchor.constraint(equalTo: self.signUpTextButton.bottomAnchor, constant: 32).isActive = true
         self.loginButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
         self.loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true
        self.loginButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
         //self.loginButton.widthAnchor.constraint(equalToConstant: ).isActive = true
         self.loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        */
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /*
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo!
        let keyboardEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = fullScrollView.convert(keyboardEndFrame, from: fullScrollView.window)
        self.fullScrollView.setContentOffset(CGPoint(x: 0, y: keyboardViewEndFrame.height-self.upperView.frame.height), animated: true)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.fullScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }*/
}

extension LoginViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
}
