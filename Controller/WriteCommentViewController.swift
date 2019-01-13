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

// 수정해야할 부분 : 댓글 작성 후 바로 업데이트 안됨ㅠㅠ

class WriteCommentViewController: UIViewController {

    var userInfo: UserInformation = UserInformation()

    weak var commentDelegate: WritedCommentDelegate?
    let tapGesture = UITapGestureRecognizer()
    
    let commentTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "이 사람에 대해서 어떻게 생각하세요?"
        textView.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textView.font = .systemFont(ofSize: 18)
        return textView
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    let okButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 17
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentTextView.delegate = self
        tapGesture.delegate = self
        setLayout()
    }
    
    func setLayout() {
        self.view.addGestureRecognizer(tapGesture)
        self.view.backgroundColor = .white
        self.view.addSubview(commentTextView)
        self.view.addSubview(backButton)
        self.view.addSubview(okButton)
        
        backButton.addTarget(self, action: #selector(touchUpBackButton(_:)), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(touchUpOkButton(_:)), for: .touchUpInside)
        
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 10).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        okButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        okButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        okButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        commentTextView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 15).isActive = true
        commentTextView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 15).isActive = true
        commentTextView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -15).isActive = true
        commentTextView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }
    
    
    
    @objc func touchUpBackButton(_: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func touchUpOkButton(_: UIButton) {
        if self.commentTextView.textColor == #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1) || self.commentTextView.text == "" {
            let alertController = UIAlertController(title: "알림", message: "후기를 작성해주세요", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            
            self.present(alertController, animated: false)
        } else {
            let userId = self.userInfo.userUid
            guard let writer = Auth.auth().currentUser?.uid else {
                return
            }
            
            Database.database().reference().child("users").child(writer).observeSingleEvent(of: DataEventType.value) { [weak self] (snapshot) in
                
                guard let value = snapshot.value as? NSDictionary else {
                    return
                }
                
                guard let imageUrl = value["userImageUrl"] as? String, let writerName = value["userName"] as? String else {
                    return
                }
                 Database.database().reference().child("users").child(userId).child("comments").child(writer).updateChildValues(["writerName": writerName])
                Database.database().reference().child("users").child(userId).child("comments").child(writer).updateChildValues(["writerImageUrl": imageUrl])
                Database.database().reference().child("users").child(userId).child("comments").child(writer).updateChildValues(["comment": self?.commentTextView.text])
                
                DispatchQueue.main.async {
                    self?.commentDelegate?.writedComment()
                    self?.dismiss(animated: true, completion: nil)
                }
            }
           
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
            textView.text = "이 사람에 대해서 어떻게 생각하세요?"
            textView.textColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        }
    }
}

extension WriteCommentViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        view.endEditing(true)
        return true
    }
}
