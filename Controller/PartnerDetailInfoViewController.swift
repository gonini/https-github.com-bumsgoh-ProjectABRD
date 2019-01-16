//
//  PartnerDetailInfoViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 6..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit
import Firebase

class PartnerDetailInfoViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let detailInfoCellId = "cellId"
    fileprivate let detailInfoHeaderId = "headerId"
    fileprivate let detailPlanAndLikesHeaderId = "planAndLikesheaderId"
    fileprivate let detailInfoFooterId = "footerId"
    fileprivate let tempId = "tmpId"
    fileprivate let padding: CGFloat = 16
    
    var roomId: String?
    var userInfos: UserInformation = UserInformation()
    var comments: [Comment] = []
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.layer.zPosition = .greatestFiniteMagnitude
        button.setImage(#imageLiteral(resourceName: "cancel"), for: .normal)
        return button
    }()
    
    var profileHeaderView: PartnerDetailHeaderReusableView?
    var planHeaderView: PlanAndLikesCollectionReusableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.addSubview(backButton)
        backButton.addTarget(self, action: #selector(touchUpCloseButton(_:)), for: .touchUpInside)
        setCommentsData()
        setUpCollectionView()
        setUpCollectionViewLayout()
        collectionView.isPrefetchingEnabled = false
        //alwaysBounceVertical을 true로 하면 셀이 없어도 스크롤이 가능하다.
        collectionView.alwaysBounceVertical = true
    }
   
    func setCommentsData() {
        var result: [Comment] = []
        Database.database().reference().child("users").child(userInfos.userUid).child("comments").observeSingleEvent(of: DataEventType.value) { [weak self] (snapshot) in
            if let data = snapshot.children.allObjects as? [DataSnapshot] {
                
                data.forEach {
                    guard let dict = $0.value as? NSDictionary else {
                        return
                    }
                    
                    guard let name = dict["writerName"] as? String, let imageUrl = dict["writerImageUrl"] as? String, let text = dict["comment"] as? String else {
                        return
                    }
                    
                    let comment = Comment(writerImageUrl: imageUrl, writerName: name, comment: text)
                    result.append(comment)
                    
                }
            }
            self?.comments = result
            
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
            
        }
    }
    
    fileprivate func setUpCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
            layout.sectionFootersPinToVisibleBounds = true
        }
    }
    
    fileprivate func setUpCollectionView() {
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInsetAdjustmentBehavior = .never
    collectionView.register(PartnerDetailViewCommentCellCollectionViewCell.self, forCellWithReuseIdentifier: detailInfoCellId)
        
        collectionView.register(PartnerDetailHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: detailInfoHeaderId)
        collectionView.register(PlanAndLikesCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: detailPlanAndLikesHeaderId)
        collectionView.register(PartnerDetailBottomView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: detailInfoFooterId)
        collectionView.register(TempCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: tempId)
        
    }
    
    func checkChatRoom(_ completionHandler: @escaping (()->())) {
        Database.database().reference().child("chatRooms").queryOrdered(byChild: "users/\(userInfos.userUid)").queryEqual(toValue: true).observeSingleEvent(of: .value) { [weak self] (dataSnapshot) in
            guard let objects = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            for item in objects {
                if let targetUserDict = item.value as? [String: Bool] {
                    if targetUserDict[self?.userInfos.userUid ?? ""]! == true {
                        self?.roomId = item.key
                    }
                }
                self?.roomId = item.key
            }
            DispatchQueue.main.async {
                completionHandler()
            }
            
        }
    }
    
    @objc func touchUpCloseButton(_: UIButton) {
        profileHeaderView?.animator.stopAnimation(true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func createChatRoom(sender: UIButton) {
        sender.isEnabled = false
        checkChatRoom() { [weak self] in
            guard let self = self else {
                    return
                
                }
            guard let uid = Auth.auth().currentUser?.uid else {
                return
            }
        
            let dstUid = self.userInfos.userUid
            let roomInfo : [String: [String: Bool]] = [ "users" : [
                uid: true,
                dstUid :true
                ]
            ]
            print("uid is..\(uid)")
        if self.roomId == nil {
            
            Database.database().reference().child("chatRooms").childByAutoId().setValue(roomInfo) { (error, reference) in
                if error != nil {
                    self.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.requestFailed),animated: false)
                    return
                }
                self.checkChatRoom(){
                    let chattingVC: ChatViewController = ChatViewController()
                    chattingVC.roomId = self.roomId ?? ""
                    chattingVC.destinationUid = self.userInfos.userUid
                    self.dismiss(animated: false, completion: {
                        //self.navigationController?.popToRootViewController(animated: true)
                        guard let appDelegateWindow = UIApplication.shared.keyWindow else {
                            return
                        }
                        if let rootViewController = appDelegateWindow.rootViewController as? UINavigationController {
                            rootViewController.pushViewController(chattingVC, animated: false)
                            if let tabBarController = rootViewController.viewControllers.first as? MainTabBarController {
                                // print(tabBarController)
                               tabBarController.selectedIndex = 1
                               //tabBarController.navigationController?.pushViewController(chattingVC, animated: false)
                            }
                       //     rootViewController.present(chattingVC, animated: true, completion: nil)
                        }
                    })
                }
            }
            
        } else {
            let chattingVC: ChatViewController = ChatViewController()
            chattingVC.roomId = self.roomId ?? ""
            chattingVC.destinationUid = self.userInfos.userUid
            self.dismiss(animated: false, completion: {
                //self.navigationController?.popToRootViewController(animated: true)
                
                guard let appDelegateWindow = UIApplication.shared.keyWindow else {
                    return
                }
                if let rootViewController = appDelegateWindow.rootViewController as? UINavigationController {
                   rootViewController.pushViewController(chattingVC, animated: false)
                    if let tabBarController = rootViewController.viewControllers.first as? MainTabBarController {
                       tabBarController.selectedIndex = 1
                       // print(tabBarController)
                        // tabBarController.present(chattingVC, animated: false)
                        //tabBarController.navigationController?.pushViewController(chattingVC, animated: false)

                    }
                    //rootViewController.present(chattingVC, animated: true, completion: nil)
                }
            })
            }
        
    }
    }
        
    @objc func moveToWriteCommentController(_: UIButton) {
        let nextViewController = WriteCommentViewController()
        nextViewController.userInfo = self.userInfos
        nextViewController.commentDelegate = self
        self.present(nextViewController, animated: true, completion: nil)
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.comments.count > 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailInfoCellId, for: indexPath) as? PartnerDetailViewCommentCellCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            guard let urlString = comments[indexPath.item].writerImageUrl else {
                return UICollectionViewCell()
            }
            
            guard let imageUrl: URL = URL(string: urlString) else {
                return UICollectionViewCell()
            }
            
            NetworkManager.shared.getImageWithCaching(url: imageUrl) { [weak self] (image, error) in
                if error != nil {
                    self?.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.requestFailed),animated: false)
                    return
                }
                
                guard let image = image else {
                    return
                }
                
                DispatchQueue.main.async {
                    cell.profileImageView.image = image
                }
                
            }
            
            cell.contentView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 0.3267069777)
            cell.memberNameLabel.text = comments[indexPath.item].writerName
            cell.commentTextView.text = comments[indexPath.item].comment
            
            cell.contentView.isUserInteractionEnabled = false
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailInfoCellId, for: indexPath) as? PartnerDetailViewCommentCellCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.contentView.backgroundColor = UIColor.white
            cell.commentTextView.text = ""
            cell.memberNameLabel.text = "this member has no comment yet"
            
            return cell
        }
        
    }

    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let section = indexPath.section
       
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if section == 0 {
                profileHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: detailInfoHeaderId, for: indexPath) as? PartnerDetailHeaderReusableView
                
                guard let headerView = profileHeaderView else {
                    return UICollectionReusableView.init()
                    
                }
                
                guard let url: URL = URL(string: userInfos.profileImageUrl) else {
                    return UICollectionReusableView.init()
                }
                NetworkManager.shared.getImageWithCaching(url: url) { [weak self] (image, error) in
                    if error != nil {
                        self?.present(ErrorHandler.shared.buildErrorAlertController(error: APIError.requestFailed), animated: false, completion: nil)
                        return
                    }
                    DispatchQueue.main.async {
                        headerView.profileImageView.image = image
                    }
                }
                headerView.userAgeLabel.text = userInfos.userAge
                headerView.userNameLabel.text = userInfos.userName.uppercased()

                backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
                backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
                backButton.topAnchor.constraint(equalTo: collectionView.safeAreaLayoutGuide.topAnchor, constant: 5).isActive = true
                backButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10).isActive = true
                
                return headerView
                
            } else if section == 1 {
                planHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: detailPlanAndLikesHeaderId, for: indexPath) as? PlanAndLikesCollectionReusableView
                //
                
                guard let headerView = planHeaderView else {
                    return UICollectionReusableView.init()
                    
                }
        
                headerView.writeCommentButton.addTarget(self, action: #selector(moveToWriteCommentController(_:)), for: .touchUpInside)
                headerView.writeCommentTextButton.addTarget(self, action: #selector(moveToWriteCommentController(_:)), for: .touchUpInside)
                
                if userInfos.planContents == "" {
                    headerView.planLabel.text = "아직 여행 계획이 작성되지 않았습니다."
                    headerView.planLabel.textColor = .lightGray
                } else {
                    headerView.planLabel.text = userInfos.planContents
                }
                
                return headerView
            }
        case UICollectionView.elementKindSectionFooter:
            if section == 1 {
                guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: detailInfoFooterId, for: indexPath) as? PartnerDetailBottomView else {
                    return UICollectionReusableView.init()
                }
                footerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                footerView.createChatRoomButton.addTarget(self, action: #selector(createChatRoom), for: .touchUpInside)
                return footerView
            } else {
                return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: tempId, for: indexPath)
            }
        default:
            return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: tempId, for: indexPath)
    }
         return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: tempId, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
       
        switch section {
        case 0:
            return .init(width: view.frame.width, height: 350)
        case 1:
       
            if userInfos.planContents == "" {
                return .init(width: view.frame.width, height: 100)
            } else {
                let size: CGSize = CGSize(width: view.frame.width, height: 250)
                let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedForm = NSString(string: userInfos.planContents).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], context: nil)

                return .init(width: view.frame.width, height: estimatedForm.height+70)
            }
        
        default:
            return .init(width: view.frame.width, height: 350)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 1 {
            return .init(width: view.frame.width, height: 100)
        } else {
             return .init(width: view.frame.width, height: 1)
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.comments.count > 0 {
        guard let commentString = self.comments[indexPath.item].comment else {
            return CGSize()
        }
        
        let size: CGSize = CGSize(width: view.frame.width, height: 250)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedForm = NSString(string: commentString).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
        
        return .init(width: view.frame.width - 2 * padding, height: estimatedForm.height + 90)
        } else {
            return .init(width: view.frame.width - 2 * padding, height: 100)
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffSetY = scrollView.contentOffset.y
        if contentOffSetY > 0 {
            profileHeaderView?.animator.fractionComplete = 0
            return
        }
        collectionViewLayout.invalidateLayout()
        profileHeaderView?.animator.fractionComplete = abs(contentOffSetY) / 100
        
        if contentOffSetY < -200 {
            profileHeaderView?.animator.stopAnimation(true)
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 0
        case 1:
            return self.comments.count > 0 ? self.comments.count : 1
        default:
            return 1
        }
        
    }
    
}

extension PartnerDetailInfoViewController: WritedCommentDelegate {
    func writedComment() {
        setCommentsData()
    }
}
