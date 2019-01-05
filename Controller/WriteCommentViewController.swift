//
//  WriteCommentViewController.swift
//  AbroadApp
//
//  Created by 이혜주 on 04/01/2019.
//  Copyright © 2019 고상범. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class WriteCommentViewController: UIViewController {

    var userInfo: UserInformation = UserInformation()
    
    let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "username"
        return label
    }()
    
    let commentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "후기를 작성해주세요"
        textView.textColor = #colorLiteral(red: 0.8781575561, green: 0.8822220564, blue: 0.89215523, alpha: 1)
        textView.font = .systemFont(ofSize: 18)
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 2
        textView.layer.cornerRadius = 5
        return textView
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("완료", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.delegate = self
        setLayout()
    }
    
    func setLayout() {
//        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.title = "후기 작성"
//        self.navigationController?.navigationBar.topItem?.title = "후기 작성"
//
//        self.navigationItem.backBarButtonItem = backButton
//        self.navigationItem.rightBarButtonItem = okButton
//
        self.view.addSubview(userNameLabel)
        self.view.addSubview(commentTextView)
        self.view.addSubview(backButton)
        self.view.addSubview(okButton)
        
        backButton.addTarget(self, action: #selector(touchUpBackButton(_:)), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(touchUpOkButton(_:)), for: .touchUpInside)
        
        userNameLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        
        commentTextView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10).isActive = true
        commentTextView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        commentTextView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        commentTextView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        backButton.topAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        okButton.topAnchor.constraint(equalTo: commentTextView.bottomAnchor, constant: 10).isActive = true
        okButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        okButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        okButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func touchUpBackButton(_: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchUpOkButton(_: UIButton) {
        if self.commentTextView.textColor == #colorLiteral(red: 0.8781575561, green: 0.8822220564, blue: 0.89215523, alpha: 1) || self.commentTextView.text == "" {
            let alertController = UIAlertController(title: "알림", message: "후기를 작성해주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: false)
        } else {
            print(self.userInfo.userUid)
            let userId = self.userInfo.userUid
            guard let writer = Auth.auth().currentUser?.uid else { return }
            var writerImageUrl = ""
//            Database.database().reference().child("users").child(writer).observeSingleEvent(of: DataEventType.value) { [weak self] (snapshot) in
//                if let data = snapshot.children.allObjects as? [DataSnapshot] {
//                    data.compactMap {
//                        guard let dict = $0.value as? NSDictionary else {
//                            fatalError()
//                        }
//
//                        guard let url = dict["userImageUrl"] as? String else {
//                            return
//                        }
//                        writerImageUrl = url
//                    }
//                }
//            }
            Database.database().reference().child("users").child(userId).child("comments").child(writer).updateChildValues(["comment": commentTextView.text])
//            Database.database().reference().child("users").child(userId).child("comments").child(writer).updateChildValues(["writerImageUrl": writerImageUrl])
            self.dismiss(animated: true, completion: nil)
        }
    }
}


extension WriteCommentViewController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        textView.textColor = .black
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "소개를 입력해주세요"
            textView.textColor = #colorLiteral(red: 0.8781575561, green: 0.8822220564, blue: 0.89215523, alpha: 1)
        }
    }
}
