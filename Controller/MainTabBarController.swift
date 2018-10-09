//
//  MainTabBarController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 6..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeViewControllers()
    }
    
    func makeViewControllers() {
        let countyDetailViewController = CountryDetailSelectedViewController()
        countyDetailViewController.tabBarItem = UITabBarItem(title: "map", image: #imageLiteral(resourceName: "map-2"), tag: 0)
        
        let chatListsViewController = ChatListTableViewController()
        chatListsViewController.tabBarItem = UITabBarItem(title: "chatRooms", image: #imageLiteral(resourceName: "living-room-books-group"), tag: 1)
        
        let myPageViewController = MyPageViewController()
        myPageViewController.tabBarItem = UITabBarItem(title: "chatRooms", image: #imageLiteral(resourceName: "man-user"), tag: 2)
        let viewControllers = [countyDetailViewController, chatListsViewController, myPageViewController]
        self.setViewControllers(viewControllers, animated: false)
    }
}
