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
    let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.backgroundColor = .white
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
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "add")
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
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
        textField.placeholder = "비밀번호를 다시 입력해주세요"
        return textField
    }()
    
    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2.0
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 15
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
//        self.view.backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        self.view.backgroundColor = .white
        self.tapGesture.delegate = self
        self.idTextField.delegate = self
        self.imagePicker.delegate = self
        UISetUp()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonClicked(sender:)))
    }

    @objc func nextButtonClicked(sender: UIBarButtonItem) {
        let vc: SignUpSexAndAgeViewController = SignUpSexAndAgeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
        
        self.mainView.addSubview(signUpLabel)
        self.mainView.addSubview(outsideStackView)
        self.mainView.addSubview(buttonStackView)
        
        self.view.addSubview(mainView)
        self.view.addGestureRecognizer(tapGesture)
        self.profileImageView.addGestureRecognizer(tapImageView)
        
        self.backButton.addTarget(self, action: #selector(touchUpCancelButton(_:)), for: .touchUpInside)
        self.nextButton.addTarget(self, action: #selector(touchUpNextButton(_:)), for: .touchUpInside)
        
        
        self.mainView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
        self.mainView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        self.mainView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        self.mainView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 5).isActive = true
        
        self.signUpLabel.bottomAnchor.constraint(equalTo: self.outsideStackView.topAnchor, constant: -40).isActive = true
        self.signUpLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.profileImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.profileImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        self.idLabel.widthAnchor.constraint(equalToConstant: 65).isActive = true
        
        self.passwordLabel.widthAnchor.constraint(equalToConstant: 65).isActive = true
        
        self.outsideStackView.centerXAnchor.constraint(equalTo: self.mainView.centerXAnchor).isActive = true
        self.outsideStackView.centerYAnchor.constraint(equalTo: self.mainView.centerYAnchor, constant: -20).isActive = true
        
        self.buttonStackView.topAnchor.constraint(equalTo: self.outsideStackView.bottomAnchor, constant: 50).isActive = true
        self.buttonStackView.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor, constant: 50).isActive = true
        self.buttonStackView.trailingAnchor.constraint(equalTo: self.mainView.trailingAnchor, constant: -50).isActive = true
    }
    
    @objc func touchUpCancelButton(_: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func touchUpNextButton(_: UIButton) {
        let vc: SignUpSexAndAgeViewController = SignUpSexAndAgeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func touchUpProfileImageView(_: UIImageView) {
        print("click imageView")
        self.present(self.imagePicker, animated: true, completion: nil)
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
        self.view.endEditing(true)
        return true
    }
}

extension SignUpInfosViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let editImage: UIImage = info[UIImagePickerControllerEditedImage] as? UIImage{
            self.profileImageView.image = editImage
        } else if let originalImage: UIImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            self.profileImageView.image = originalImage
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension SignUpInfosViewController: UINavigationControllerDelegate {}
