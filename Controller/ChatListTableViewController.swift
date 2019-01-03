//
//  ChatListTableViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 5..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class ChatListTableViewController: UITableViewController {
    
    let cellIdentifier: String = "chatCell"
    var chatRooms: [ChatRoom] = [] {
        didSet {
            OperationQueue.main.addOperation {[weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(ChatListTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        setTableView()
        
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
        cell.chatMemberLabel.text = chatRooms[indexPath.row].chatMember
        cell.chatLabel.text = chatRooms[indexPath.row].message
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let VC: ChatViewController = ChatViewController()
        VC.roomId = chatRooms[indexPath.row].roomId
      
        self.navigationController?.pushViewController(VC, animated: true)
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
