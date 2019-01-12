//
//  ChatListTableViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 5..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class ChatListTableViewController: UITableViewController {

    var destinationUsers: [String] = []
    var uid: String = ""

    let cellIdentifier: String = "chatCell"
    var chatRooms: [ChatModel] = [] {
        didSet {
            OperationQueue.main.addOperation {[weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getChatRooms()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ChatListTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        setTableView()
        
        
        }

    
    func getChatRooms() {
        guard let uid  = Auth.auth().currentUser?.uid else {
            
            return
        }
        self.uid = uid
        self.chatRooms.removeAll()
        Database.database().reference().child("chatRooms").queryOrdered(byChild: "users/"+uid).queryEqual(toValue: true).observeSingleEvent(of: .value) { [weak self] (dataSnapshot) in
            //print("value: \(dataSnapshot.children.allObjects)")
            for item in dataSnapshot.children.allObjects as! [DataSnapshot] {
                print("value: \(item.key)")
                if let chatRoomDict = item.value as? NSDictionary {
                    guard let users = chatRoomDict["users"] as? [String: Bool], let comments = chatRoomDict["comments"] as? [String: [String: String]] else {
                        print("casting failure")
                        return
                    }
                    //let comment = comments["]
                    let chatRoom = ChatModel(roomId: item.key, users: users, comments: comments, url: "", name: "", uid: "")
                    print("is..\(chatRoom)")
                    self?.chatRooms.append(chatRoom)
                    
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    fileprivate func setTableView() {
        self.tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chatRooms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ChatListTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChatListTableViewCell else {
            return UITableViewCell.init()
        }
        cell.chatMemberLabel.text = chatRooms[indexPath.row].userName
    
        var destinationUid: String = ""
        for item in chatRooms[indexPath.row].users {
            if item.key != self.uid {
                destinationUid = item.key
                destinationUsers.append(destinationUid)
            }
        }
        
        Database.database().reference().child("users").child(destinationUid).observeSingleEvent(of: .value) { [weak self] (dataSnapshot) in
            
            if let dict = dataSnapshot.value as? NSDictionary {
                
                    guard let name = dict["userName"] as? String, let uid = dict["uid"] as? String, let sex = dict["sex"] as? String, let country = dict["country"] as? String , let age = dict["age"] as? String, let url = dict["userImageUrl"] as? String else {
                        
                        return
                    }
                var userInfo = UserInformation()
                userInfo.userUid = uid
                userInfo.userName = name
                userInfo.userSex = sex
                userInfo.userConuntry = country
                userInfo.userAge = age
                userInfo.profileImageUrl = url
                cell.chatMemberLabel.text = userInfo.userName
                cell.chatLabel.text = ""
                
                guard let imageUrl = URL(string: userInfo.profileImageUrl) else {
                    
                    return
                }
                NetworkManager.shared.getImageWithCaching(url: imageUrl, completion: { (image, error) in
                    if let error = error {
                        return
                    }
                    
                    DispatchQueue.main.async {
                         cell.profileImageView.image = image
                    }
                })
                }
            guard let lastMessagekey = self?.chatRooms[indexPath.row].comments.keys.sorted() else {
           
                return
            }
            cell.chatLabel.text = self?.chatRooms[indexPath.row].comments[lastMessagekey[0]]?["message"]
            }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let chattingVC: ChatViewController = ChatViewController()
        chattingVC.roomId = chatRooms[indexPath.row].roomId
        chattingVC.destinationUid = destinationUsers[indexPath.row]
        let listBasedNavigationController = UINavigationController(rootViewController: chattingVC)
       // listBasedNavigationController.pushViewController(chattingVC, animated: false)
        self.present(listBasedNavigationController, animated: true)
        let VC: ChatViewController = ChatViewController()
        VC.roomId = chatRooms[indexPath.row].roomId
        self.navigationController?.pushViewController(chattingVC, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return self.chatRooms.count > 0 ? 0 : 100
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "no chat rooms"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }

}
