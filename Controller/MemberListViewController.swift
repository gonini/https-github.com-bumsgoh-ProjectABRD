//
//  ViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 9. 17..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class MemberListViewController: UIViewController {
    
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
    
    let onoffArr: [UIImage] = [#imageLiteral(resourceName: "onbutton"),#imageLiteral(resourceName: "offbutton")]
    let cellIdentifier: String = "countryCell"
    /*let regionRadius: CLLocationDistance = 10000
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    */
    let bulletBoardTableView: UITableView = {
        let tableview = UITableView()
        tableview.translatesAutoresizingMaskIntoConstraints = false
        return tableview
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        getUserDateFromDB()
       // userInformationArray = getUserDateFromDB()
        self.bulletBoardTableView.register(PartnersTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.bulletBoardTableView.dataSource = self
        self.bulletBoardTableView.delegate = self
        UISetUp()
        setTableView()
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
        
        guard let user = Auth.auth().currentUser else {
            
            return
        }
        
        Database.database().reference().child("users").observeSingleEvent(of: DataEventType.value) { [weak self] (snapshot) in
            
            if let data = snapshot.children.allObjects as? [DataSnapshot] {
                data.forEach {
                    guard let dict = $0.value as? NSDictionary else {
                        fatalError()
                    }

                    guard let name = dict["userName"] as? String, let uid = dict["uid"] as? String, let sex = dict["sex"] as? String, let country = dict["country"] as? String , let age = dict["age"] as? String, let url = dict["userImageUrl"] as? String, let contents = dict["planContents"] as? String else {
                        
                        return
                    }
                    if uid == user.uid {
                        
                    } else {
                        var userInfo = UserInformation()
                        userInfo.userUid = uid
                        userInfo.userName = name
                        userInfo.userSex = sex
                        userInfo.userConuntry = country
                        userInfo.userAge = age
                        userInfo.profileImageUrl = url
                        userInfo.planContents = contents
                        result.append(userInfo)
                        
                    }

                }
            }
        self?.userInformationArray = result
        }
    }
}


extension MemberListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInformationArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: PartnersTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PartnersTableViewCell else {return UITableViewCell.init()}
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
