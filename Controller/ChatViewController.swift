//
//  ChatViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 9. 18..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController {
    
    var destinationUid: String = ""
    let reuseIdentifier: String = "chatBubbleCell"
    var roomId: String = ""
    var isFirstAddedChild: Bool = true
    var userImageUrl: String = ""
    
    var messages: [[String: Any]] = [] {
        didSet {
            DispatchQueue.main.async {[weak self] in
           //  self?.chatCollectionView.reloadData()
               
            }
        }
    }
    
    var width: CGFloat?

    var bottomConstraint: NSLayoutConstraint = NSLayoutConstraint()
    var isKeyboardShowOnce: Bool = false
    
    let chatCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.white
        return collectionView
    }()
    
    let chatInputBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    let chatTextView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isEditable = true
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let chatSendButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("send", for: UIControl.State.normal)
        button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: UIControl.State.normal)
       
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
  
        chatTextView.text = "Type your message"
        chatTextView.textColor = UIColor.lightGray
        chatTextView.delegate = self
        
        chatCollectionView.delegate = self
        chatCollectionView.dataSource = self
        chatCollectionView.register(ChatBubbleCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.view.backgroundColor = UIColor.white
        
        if #available(iOS 11.0, *) {
            chatCollectionView.contentInsetAdjustmentBehavior = .always
        }
        
        if UIDevice.current.orientation.isPortrait == true {
            width = UIScreen.main.bounds.width
        } else {
            width = UIScreen.main.bounds.height
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        UISetUp()
        self.chatSendButton.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Database.database().reference().removeAllObservers()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
    
        fetchMessages()
    }
    
    func UISetUp() {
        self.view.addSubview(chatCollectionView)
        self.view.addSubview(chatInputBackgroundView)
        
        self.chatInputBackgroundView.addSubview(chatTextView)
        self.chatInputBackgroundView.addSubview(chatSendButton)
        
        self.chatCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.chatCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.chatCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.chatCollectionView.bottomAnchor.constraint(equalTo: self.chatInputBackgroundView.topAnchor).isActive = true
        
        self.chatInputBackgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.chatInputBackgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.chatInputBackgroundView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        let bottomConstraint = NSLayoutConstraint(item: chatInputBackgroundView, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 4)
        self.bottomConstraint = bottomConstraint
        bottomConstraint.isActive = true //키보드가 올라왔을때 뷰를 조정하기 위해서 따로 설정하였습니다.
        
        self.chatTextView.topAnchor.constraint(equalTo: self.chatInputBackgroundView.topAnchor).isActive = true
        self.chatTextView.leadingAnchor.constraint(equalTo: self.chatInputBackgroundView.leadingAnchor, constant: 16).isActive = true
        self.chatTextView.widthAnchor.constraint(equalTo: self.chatInputBackgroundView.widthAnchor, multiplier: 0.6).isActive = true
        self.chatTextView.bottomAnchor.constraint(equalTo: self.chatInputBackgroundView.bottomAnchor).isActive = true
        
        //self.chatSendButton.topAnchor.constraint(equalTo: self.chatInputBackgroundView.topAnchor).isActive = true
        self.chatSendButton.centerYAnchor.constraint(equalTo: self.chatInputBackgroundView.centerYAnchor).isActive = true
        self.chatSendButton.trailingAnchor.constraint(equalTo: self.chatInputBackgroundView.trailingAnchor, constant: -8).isActive = true
        //self.chatSendButton.trailingAnchor.constraint(equalTo: self.chatInputBackgroundView.trailingAnchor, constant: -16).isActive = true
        self.chatSendButton.heightAnchor.constraint(lessThanOrEqualToConstant: 30).isActive = true
        self.chatSendButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc func sendButtonClicked() {
        guard let user = Auth.auth().currentUser else {
            return
        }
        let data: [String: Any] =  ["uid": user.uid, "message": chatTextView.text!, "timeStamp": ServerValue.timestamp()]
        
        Database.database().reference().child("chatRooms").child(roomId).child("comments").childByAutoId().setValue(data) { [weak self] (error, DatabaseReference) in
            if error != nil {
                self?.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.responseUnsuccessful), animated: false)
                return
            }
            DispatchQueue.main.async {
                self?.chatTextView.text = ""
            }
           // self?.fetchMessages()
        }
       
    }

    func adjustingHeight(_ show:Bool, notification:NSNotification) {
        guard let userInfo = notification.userInfo else { return }
        guard let keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey]) as? CGRect else { return }
        guard let animationDurarion: TimeInterval = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {return}
        let changeInHeight = (keyboardFrame.height) * (show ? 1 : -1)
        UIView.animate(withDuration: animationDurarion, animations: {() in
            self.bottomConstraint.constant -= changeInHeight
        })
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if !isKeyboardShowOnce{
            adjustingHeight(true, notification: notification)
        }
        isKeyboardShowOnce = true
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        adjustingHeight(false, notification: notification)
        isKeyboardShowOnce = false
    }
    
    func fetchMessages() {
        Database.database().reference().child("chatRooms").child(roomId).child("comments").observe(.value) { [weak self] (dataSnapshot) in
            guard let self = self else {
                return
            }
            self.messages.removeAll()
            for message in dataSnapshot.children.allObjects as! [DataSnapshot] {
               guard let commentDict = message.value as? NSDictionary else {
                    return
                }
                guard let message = commentDict["message"] as? String, let uid = commentDict["uid"] as? String , let time = commentDict["timeStamp"] as? Int else {
                    return
                }
                let messageDict = ["message": message, "uid": uid, "timeStamp": time] as [String : Any]
                self.messages.append(messageDict)
            }
            
            self.chatCollectionView.reloadData()
            let item = self.messages.count - 1
            let insertedIndex = IndexPath(item: item, section: 0)
            if self.messages.count > 0{
                self.chatCollectionView.scrollToItem(at: insertedIndex, at: .bottom, animated: true)
                
            }
        }
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let user = Auth.auth().currentUser else {
            return CGSize.init()
        }
        guard let uid = messages[indexPath.row]["uid"] as? String else {
            return CGSize.init()
        }
        //let messageText: [String: Any] = self.messages[indexPath.row]
        guard let text = messages[indexPath.row]["message"] as? String else {
            print("message error")
            return CGSize.init()
        }
        if uid != user.uid {
            let size: CGSize = CGSize(width: 250, height: 100)
            let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedForm = NSString(string: text).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
            return CGSize(width: self.view.frame.width, height: estimatedForm.height + 38)
        }
        let size: CGSize = CGSize(width: 250, height: 100)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedForm = NSString(string: text).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        return CGSize(width: self.view.frame.width, height: estimatedForm.height + 20)
        
    }
}

extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ChatBubbleCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ChatBubbleCollectionViewCell else {
            
            return UICollectionViewCell.init()
        }

        guard let text = messages[indexPath.row]["message"] as? String, let uid = messages[indexPath.row]["uid"] as? String, let time = messages[indexPath.row]["timeStamp"] as? Int else {
            
            print("message error")
            return UICollectionViewCell.init()
        }
        
        let size: CGSize = CGSize(width: 250, height: 1000)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedForm = NSString(string: text).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], context: nil)
        guard let user = Auth.auth().currentUser else {
            return UICollectionViewCell()
        }
        
        if uid != user.uid {
            cell.chatTextView.frame = CGRect(x: 40 + 8, y: 0, width: estimatedForm.width + 16, height: estimatedForm.height + 16)
            cell.textBubbleView.frame = CGRect(x: 40, y: 0, width: estimatedForm.width + 24, height: estimatedForm.height + 16)
            cell.timeStampLabel.frame = CGRect(x: 48, y: estimatedForm.height + 8, width: collectionView.frame.width / 2, height: estimatedForm.height + 16)
            cell.textBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
            cell.chatTextView.textColor = UIColor.black
            guard let imageUrl = URL(string: userImageUrl) else {
                print("url error")
                return UICollectionViewCell.init()
            }
            NetworkManager.shared.getImageWithCaching(url: imageUrl) { [weak self] (image, error) in
                if error != nil {
                    self?.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.responseUnsuccessful), animated: false, completion: nil)
                }
                DispatchQueue.main.async {
                    cell.thumbNailImageView.image = image
                }
            }
            cell.timeStampLabel.text = time.toDate
        } else {
            cell.chatTextView.frame = CGRect(x: (self.view.frame.width - estimatedForm.width - 28), y: 0, width: estimatedForm.width + 16, height: estimatedForm.height + 16)
            cell.textBubbleView.frame = CGRect(x: self.view.frame.width - estimatedForm.width - 32, y: 0, width: estimatedForm.width + 24, height: estimatedForm.height + 16)
            cell.textBubbleView.backgroundColor = UIColor(red: 0, green: 137/245, blue: 249/255, alpha: 1)
            cell.chatTextView.textColor = UIColor.white
        }
        cell.chatTextView.text = text
       
        return cell
    }
}


extension ChatViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type your message"
            textView.textColor = UIColor.lightGray
        }
    }
}
