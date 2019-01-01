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
    
    var userInformationArray: [UserInformation] = [] {
        
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.bulletBoardTableView.reloadData()
            }
            
        }
    }
    
    let imageArr: [UIImage] = [#imageLiteral(resourceName: "hairstyle-2"),#imageLiteral(resourceName: "hairstyle-3")]
    let introArr: [String] = ["안녕하세요, 이번에 뮌헨에서 10월 7일부터 9일까지 여행하게되었습니다. 같이 동행하실분 연락주세요!", "프랑크푸르트 ~ 함부르크까지 같이 여행하실분 찾습니다. 나이스한 분들만", "여자3명 파리 여행합니다. 같이 여행하면서 사진찍으실분 서로 찍어주면 개꿀쓰", "이번에 독일에 교환학생왔는데 여행 같이하면 좋을거같아요 하이델베르크 같이가실 2분 구합니다! 저랑 저 친구 같이있어요~ 연락주세요"]
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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        getUserDateFromDB()
       // userInformationArray = getUserDateFromDB()
        self.bulletBoardTableView.register(PartnersTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.bulletBoardTableView.dataSource = self
        self.bulletBoardTableView.delegate = self
 
        UISetUp()
    }
    
    func UISetUp() {
        self.view.addSubview(bulletBoardTableView)
        
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
                data.compactMap{
                    guard let dict = $0.value as? NSDictionary else {
                        fatalError()
                    }
                    
                    guard let name = dict["userName"] as? String, let sex = dict["sex"] as? String, let country = dict["country"] as? String , let age = dict["age"] as? String, let url = dict["userImageUrl"] as? String else {
                        
                        return
                    }
                    var userInfo = UserInformation()
                    userInfo.userName = name
                    userInfo.userSex = sex
                    userInfo.userConuntry = country
                    userInfo.userAge = age
                    userInfo.profileImageUrl = url
                    result.append(userInfo)
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
        NetworkManager.shared.getImageWithCaching(url: imageUrl, completion: { (img, error) in
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
        
        cell.memberNameLabel.text = "\(userInformationArray[indexPath.row].userName), \(userInformationArray[indexPath.row].userAge)   \(userInformationArray[indexPath.row].userConuntry)"
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
