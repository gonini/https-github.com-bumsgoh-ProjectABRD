//
//  MainTabBarController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 6..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit
import CoreLocation


class MainTabBarController: UITabBarController {
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        makeViewControllers()
    }
    
    func makeViewControllers() {
        let countyDetailViewController = MemberListViewController()
        countyDetailViewController.tabBarItem = UITabBarItem(title: "friends", image: #imageLiteral(resourceName: "friends"), tag: 0)
        
        let chatListsViewController = ChatListTableViewController()
        chatListsViewController.tabBarItem = UITabBarItem(title: "chatRooms", image: #imageLiteral(resourceName: "living-room-books-group"), tag: 1)
        
        let myPageViewController = MyPageViewController()
        myPageViewController.tabBarItem = UITabBarItem(title: "myPage", image: #imageLiteral(resourceName: "man-user"), tag: 2)
        let viewControllers = [countyDetailViewController, chatListsViewController, myPageViewController]
        self.setViewControllers(viewControllers, animated: false)
    }
   
}
