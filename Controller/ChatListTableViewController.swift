//
//  ChatListTableViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 5..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit
import SocketIO
class ChatListTableViewController: UITableViewController {
    
    let cellIdentifier: String = "chatCell"
    var chatRooms: [ChatRoom] = [] {
        didSet {
            OperationQueue.main.addOperation {[weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    var socket: SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ChatListTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        self.socket = SocketManaging.socketManager.socket(forNamespace: "/login/chat")
        socket.connect()
        
        socket.on(clientEvent: .connect) {[weak self] data, ack in
            print("socket chat connected")
            self?.socket.emit("getChatList", "1")
            let myJSON = [
                "id0": "1",
                "id1": "0"
            ]
            
            self?.socket.emit("requestJoin", myJSON)
            
            self?.socket.on("joinSuccess") {(data,ack) in
                for fixed in data {
                    var dataDic: [String : Any] = [:]
                    print(data)
                    dataDic = (fixed as! NSDictionary) as! [String : Any]
                    let members: [String] = dataDic["joinMembers"] as! [String]
                    let roomId: String = dataDic["roomName"] as! String
                    //print(members)
                    //print(roomId)
                    let chatData: ChatRoom = ChatRoom(member: members[0], roomId: roomId)
                    self?.chatRooms.append(chatData)
                    //print("cell count : \(self?.chatRooms.count)")
                }
                //print(self?.chatRooms)
                OperationQueue.main.addOperation {
                    self?.tableView.reloadData()
                }
                //print(type(of: data))
            }
        }
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return chatRooms.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: ChatListTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChatListTableViewCell else {
            print("fucked up")
            return UITableViewCell.init()
        }
        cell.chatMemberLabel.text = chatRooms[indexPath.row].chatMember
        cell.chatLabel.text = chatRooms[indexPath.row].roomId
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let VC: ChatViewController = ChatViewController()
        VC.roomId = chatRooms[indexPath.row].roomId
        VC.socket = self.socket
        self.navigationController?.pushViewController(VC, animated: true)
    }
   

}
