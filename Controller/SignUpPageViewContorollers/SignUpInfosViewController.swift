//
//  SignUpInfosViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 5..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


// 회원가입 아이디/비밀번호 화면
class SignUpInfosViewController: UIViewController {
    
    let storage = Storage.storage()
    
    let textFieldDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return view
    }()
    
    let imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    }()
    
    let profileStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    let passwordSecurityButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("☐ 비밀번호 보기", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        return button
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "user")
        imageView.layer.cornerRadius = 50
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    lazy var tapImageView = UITapGestureRecognizer(target: self, action: #selector(touchUpProfileImageView(_:)))
    
    let signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "회원가입"
        label.font = .boldSystemFont(ofSize: 30)
        label.textColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return label
    }()
    
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
        stackView.spacing = 10
        return stackView
    }()

    let passwordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    let passwordTextFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let passwordLableStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    let idLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "아이디"
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "비밀번호"
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let idTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.setBottomBorder()
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = "사용할 아이디를 입력해주세요"
        textField.borderStyle = .none
        textField.clearButtonMode = .always
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    let passwordFirstTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.setBottomBorder()
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = "비밀번호를 입력해주세요"
        textField.clearButtonMode = .always
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let passwordCheckTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.clear
        textField.setBottomBorder()
        textField.font = .systemFont(ofSize: 16)
        textField.placeholder = "비밀번호를 다시 입력해주세요"
        textField.clearButtonMode = .always
        textField.isSecureTextEntry = true
        return textField
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("확인", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.borderColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1).cgColor
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2.0
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1), for: .normal)
        button.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2.0
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.tapGesture.delegate = self
        self.idTextField.delegate = self
        self.imagePicker.delegate = self
        
        self.idTextField.delegate = self
        self.passwordFirstTextField.delegate = self
        self.passwordCheckTextField.delegate = self

        UISetUp()
    }

    func UISetUp() {
        let tmpView = UIView()
        let tmpView2 = UIView()
        let tmpView3 = UIView()
        
        self.profileStackView.addArrangedSubview(tmpView2)
        self.profileStackView.addArrangedSubview(profileImageView)
        self.profileStackView.addArrangedSubview(tmpView3)
        
        self.outsideStackView.addArrangedSubview(profileStackView)
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
        
        self.buttonStackView.addArrangedSubview(backButton)
        self.buttonStackView.addArrangedSubview(nextButton)
        
        self.view.addSubview(signUpLabel)
        self.view.addSubview(outsideStackView)
        self.view.addSubview(passwordSecurityButton)
        self.view.addSubview(buttonStackView)
        
        self.view.addGestureRecognizer(tapGesture)
        self.profileImageView.addGestureRecognizer(tapImageView)
        
        self.backButton.addTarget(self, action: #selector(touchUpCancelButton(_:)), for: .touchUpInside)
        self.nextButton.addTarget(self, action: #selector(touchUpNextButton(_:)), for: .touchUpInside)
        self.passwordSecurityButton.addTarget(self, action: #selector(touchUpPWSecurityButton(_:)), for: .touchUpInside)
        
        self.signUpLabel.bottomAnchor.constraint(equalTo: self.outsideStackView.topAnchor, constant: -40).isActive = true
        self.signUpLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.idLabel.widthAnchor.constraint(equalToConstant: 64).isActive = true
        
        self.passwordLabel.widthAnchor.constraint(equalToConstant: 64).isActive = true
        
        self.outsideStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.outsideStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20).isActive = true
        self.outsideStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        self.outsideStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30).isActive = true
        
        self.passwordSecurityButton.topAnchor.constraint(equalTo: self.outsideStackView.bottomAnchor, constant: 15).isActive = true
        self.passwordSecurityButton.trailingAnchor.constraint(equalTo: self.outsideStackView.trailingAnchor).isActive = true

        self.buttonStackView.topAnchor.constraint(equalTo: self.passwordSecurityButton.bottomAnchor, constant: 25).isActive = true
        self.buttonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        self.buttonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        self.buttonStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    @objc func touchUpPWSecurityButton(_ sender: UIButton) {
        if sender.currentTitle == "☑︎ 비밀번호 보기" {
            self.passwordFirstTextField.isSecureTextEntry = true
            self.passwordCheckTextField.isSecureTextEntry = true
            sender.setTitle("☐ 비밀번호 보기", for: .normal)
        } else {
            self.passwordFirstTextField.isSecureTextEntry = false
            self.passwordCheckTextField.isSecureTextEntry = false
            sender.setTitle("☑︎ 비밀번호 보기", for: .normal)
        }
    }
    
    @objc func touchUpCancelButton(_: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func touchUpNextButton(_: UIButton) {
        if idTextField.text != "", passwordFirstTextField.text != "", passwordCheckTextField.text != "" {
            
            if passwordFirstTextField.text == passwordCheckTextField.text {
                let vc: SignUpSexAndAgeViewController = SignUpSexAndAgeViewController()
                Auth.auth().createUser(withEmail: idTextField.text!, password: passwordCheckTextField.text!) { [weak self] (authResult, error)  in
                    
                    guard let user = authResult?.user else {
                        
                        let alert = UIAlertController(title: "알림", message: "회원 가입 요청 실패", preferredStyle: .alert)
                        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                        alert.addAction(okButton)
                        self?.present(alert, animated: false)
                        return
                    }
                    Database.database().reference().child("users").child(user.uid).setValue(["userId": user.email])
                    let storageRef = self?.storage.reference()
                    let userProfileImageRef = storageRef?.child("userProfileImage/\(user.uid).jpg")
                  
                    guard let data = self?.profileImageView.image?.jpegData(compressionQuality: 0.1) else {
                        return
                    }
                    userProfileImageRef?.putData(data, metadata: nil) { (metadata, error) in
                        guard let metadata = metadata else {
                            return
                        }
                        userProfileImageRef?.downloadURL { (url, error) in
                            
                            if let error = error {
                                return
                            }
                            guard let url = url?.absoluteString else {
                                return
                                
                            }
                            Database.database().reference().child("users").child(user.uid).setValue(["uid": user.uid, "userId": user.email, "userImageUrl": url]  )
                        }
                    }.resume()
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
            } else {
                let alert = UIAlertController(title: "알림", message: "비밀번호가 일치하지 않습니다", preferredStyle: .alert)
                
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                
                alert.addAction(okButton)
                
                present(alert, animated: false)
            }
        } else {
            let alert = UIAlertController(title: "알림", message: "모든 정보를 입력해주세요", preferredStyle: .alert)
            
            let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            
            alert.addAction(okButton)
            
            present(alert, animated: false)
        }
    }
    
    @objc func touchUpProfileImageView(_: UIImageView) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }
}

extension SignUpInfosViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension SignUpInfosViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension SignUpInfosViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
   func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            self.profileImageView.image = editedImage
            self.profileImageView.clipsToBounds = true
        } else if let originalImage: UIImage = info[.originalImage] as? UIImage {
            self.profileImageView.image = originalImage
            self.profileImageView.clipsToBounds = true
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension SignUpInfosViewController: UINavigationControllerDelegate {}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.7)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 0.0
    }
}
