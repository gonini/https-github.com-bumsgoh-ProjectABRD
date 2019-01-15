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
    var locValue:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    lazy var filterButton: UIBarButtonItem = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 20.0, height: 20.0)
        button.setImage(#imageLiteral(resourceName: "filter"), for: .normal)
        button.addTarget(self, action: #selector(touchUpFilterButton(_:)), for: .touchUpInside)
        
        let barButton = UIBarButtonItem(customView: button)
        barButton.customView?.widthAnchor.constraint(equalToConstant: 22).isActive = true
        barButton.customView?.heightAnchor.constraint(equalToConstant: 22).isActive = true
        return barButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.rightBarButtonItem = filterButton
        
        setLocationInfo()
        makeViewControllers()
        
    }
    
    func setLocationInfo() {
        self.locationManager.requestWhenInUseAuthorization()

        //위치 데이터 정확도 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        // 몇미터 이상 움직였을때 위치 갱신시킬것인지
//        locationManager.distanceFilter = 1500.0
        locationManager.startUpdatingLocation()
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
   
    @objc func touchUpFilterButton(_: UIButton) {
        let alertController = UIAlertController(title: "Filter", message: "무슨 정보를 검색하고 싶으세요?", preferredStyle: .actionSheet)
        
        let tenMeterAction = UIAlertAction(title: "10M 이내", style: .default, handler: nil)
        let fiftyMeterAction = UIAlertAction(title: "50M 이내", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(tenMeterAction)
        alertController.addAction(fiftyMeterAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(item)
        print(tabBar.items)
        
//        switch item {
//        case 0:
//            break
//        case 1:
//            break
//        case 2:
//            break
//        default:
//            break
//        }
    }
}

extension MainTabBarController: CLLocationManagerDelegate  {
    // 여기서 데이터베이스 갱신해야되남 흠
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 사용자의 좌표정보
        locValue = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            break
        case .restricted, .denied:
            let alertController = UIAlertController(title: "Notice", message: "위치 서비스를 사용할 수 없습니다. 위치 서비스를 켜주세요", preferredStyle: .alert)
            
            let moveToSettingAction = UIAlertAction(title: "설정으로 이동", style: .destructive) { (_) in
                guard let settingURL = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingURL) {
                    UIApplication.shared.open(settingURL, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
            }
            
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alertController.addAction(moveToSettingAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
            break
        default:
            break
        }
    }
}
