//
//  ViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 9. 17..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit
import CoreLocation
import FirebaseDatabase
import FirebaseAuth

class MemberListViewController: UIViewController {
    /*let regionRadius: CLLocationDistance = 10000
     let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
     */
    let onoffArr: [UIImage] = [#imageLiteral(resourceName: "onbutton"),#imageLiteral(resourceName: "offbutton")]
    var usersDistance: [Double] = []
    let cellIdentifier: String = "countryCell"
    let userId = Auth.auth().currentUser?.uid
    let locationManager = CLLocationManager()
    var locValue:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)

    lazy var indicatorView: LoadingIndicatorView = {
        let view = LoadingIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.noticeLabel.text = "Loading List"
        return view
    }()
    
    var userInformationArray: [UserInformation] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.bulletBoardTableView.reloadData()
                self?.indicatorView.deactivateIndicatorView()
            }
        }
    }
    
    let bulletBoardTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        getUserDateFromDB()
        self.bulletBoardTableView.register(PartnersTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.bulletBoardTableView.dataSource = self
        self.bulletBoardTableView.delegate = self
        self.locationManager.delegate = self
        
        setLocationInfo()
        UISetUp()
        setTableView()
    }
    
    func setLocationInfo() {
        self.locationManager.requestWhenInUseAuthorization()
        
        //위치 데이터 정확도 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        // 몇미터 이상 움직였을때 위치 갱신시킬것인지
        locationManager.distanceFilter = 500.0
        locationManager.startUpdatingLocation()
    }
    
    fileprivate func setTableView() {
        self.bulletBoardTableView.tableFooterView = UIView()
    }
    
    func UISetUp() {
        self.view.addSubview(bulletBoardTableView)
        self.bulletBoardTableView.addSubview(indicatorView)
        
        indicatorView.widthAnchor.constraint(greaterThanOrEqualToConstant: 180).isActive = true
        indicatorView.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicatorView.activateIndicatorView()
        
        self.bulletBoardTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.bulletBoardTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.bulletBoardTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.bulletBoardTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func getUserDateFromDB() {
        var result: [UserInformation] = []
        var distanceResult: [Double] = []
        
        guard let user = Auth.auth().currentUser else {
            return
        }
        
        Database.database().reference().child("users").observeSingleEvent(of: DataEventType.value) { [weak self] (snapshot) in
            guard let myLatitude = self?.locValue.latitude, let myLongitude = self?.locValue.longitude else {
                return
            }
            
            let myLocation = CLLocation(latitude: myLatitude, longitude: myLongitude)
            
            if let data = snapshot.children.allObjects as? [DataSnapshot] {
                data.forEach {
                    guard let dict = $0.value as? NSDictionary else {
                        fatalError()
                    }

                    guard let name = dict["userName"] as? String,
                        let uid = dict["uid"] as? String,
                        let sex = dict["sex"] as? String,
                        let country = dict["country"] as? String,
                        let age = dict["age"] as? String,
                        let url = dict["userImageUrl"] as? String,
                        let contents = dict["planContents"] as? String else {
                        return
                    }
                    
                    let locationDict = dict["location"] as? [String:Double]
                    
                    if uid == user.uid {
                    } else {
                        // 위치 정보가 없는 사람은 띄우지 말아야되남
                        let latitude = locationDict?["latitude"] ?? 0.0
                        let longitude = locationDict?["longitude"] ?? 0.0
                        
                        var userInfo = UserInformation()
                        userInfo.userUid = uid
                        userInfo.userName = name
                        userInfo.userSex = sex
                        userInfo.userConuntry = country
                        userInfo.userAge = age
                        userInfo.profileImageUrl = url
                        userInfo.planContents = contents
                        userInfo.latitude = latitude
                        userInfo.longitude = longitude
                        result.append(userInfo)
                        
                        let userLocation = CLLocation(latitude: latitude, longitude: longitude)
                        
                        let distance = myLocation.distance(from: userLocation)
                        
                        distanceResult.append(distance)
                    }
                }
            }
            self?.userInformationArray = result
            self?.usersDistance = distanceResult
        }
    }
}

extension MemberListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInformationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PartnersTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PartnersTableViewCell else {
            return UITableViewCell.init()
        }
        
        guard let imageUrl: URL = URL(string: userInformationArray[indexPath.row].profileImageUrl) else {
            return .init()
        }
        
        NetworkManager.shared.getImageWithCaching(url: imageUrl, completion: {[weak self] (img, error) in
            if let error = error {
                return
            }
            
            guard let image = img else {
                return
            }
            
            DispatchQueue.main.async {
                cell.profileImageView.image = image
            }
        })
        
        cell.memberNameLabel.text = "\(userInformationArray[indexPath.row].userName) (\(userInformationArray[indexPath.row].userAge))"
        cell.countryLabel.text = "\(userInformationArray[indexPath.row].userConuntry)"
        cell.chatLabel.text = userInformationArray[indexPath.row].planContents
        cell.onOffImageView.image = onoffArr[Int.random(in: 0...1)]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC: PartnerDetailInfoViewController = PartnerDetailInfoViewController(collectionViewLayout: StretchableHeaderFlowLayout())
        
        VC.userInfos = userInformationArray[indexPath.row]
        
        self.navigationController?.present(VC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
}

extension MemberListViewController: CLLocationManagerDelegate  {
    // 여기서 데이터베이스 갱신해야되남 흠
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // 사용자의 좌표정보
        locValue = manager.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        guard let userId = userId else {
            return
        }
        
        guard let latitude = locValue.latitude as? CLLocationDegrees, let longitude = locValue.longitude as? CLLocationDegrees else {
            return
        }
        Database.database().reference().child("users").child(userId).child("location").updateChildValues(["latitude":latitude, "longitude":longitude])
        
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
