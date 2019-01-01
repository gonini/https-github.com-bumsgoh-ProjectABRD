//
//  PartnerDetailInfoViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 6..
//  Copyright © 2018년 고상범. All rights reserved.
//

/*
 변경사항 : 1. 헤더뷰를 다른 클래스 파일로 만듬 -> viewController 코드 길이 줄이는 용도 (PartnerDetailViewControllorView 폴더안에 넣어 놓음)
        2. tableViewController -> collectionViewController 로 바꿈. 각 사람마다 여행 후기를 쓰고 별점을 줄 수 있는 기능을 만드려고함.
        3. 화면을 내렸을 시 흐려지는 Blur 이펙트를 추가함
 
 
 */





import UIKit

class PartnerDetailInfoViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    fileprivate let detailInfoCellId = "cellId"
    fileprivate let detailInfoHeaderId = "headerId"
    fileprivate let detailPlanAndLikesHeaderId = "planAndLikesheaderId"
    fileprivate let detailInfoFooterId = "footerId"
    fileprivate let tempId = "tmpId"
    fileprivate let padding: CGFloat = 16
    
    var userInfos: UserInformation = UserInformation()
    
    let downArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.zPosition = .greatestFiniteMagnitude
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "swipe-down")
        return imageView
    }()
    
    let string = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    
    var profileHeaderView: PartnerDetailHeaderReusableView?
    var planHeaderView: PlanAndLikesCollectionReusableView?
    /*
    lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
    
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.addSubview(downArrowImageView)
        setUpCollectionView()
        setUpCollectionViewLayout()
        collectionView.isPrefetchingEnabled = false
        
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
    
    
    
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailInfoCellId, for: indexPath)
        return cell
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
                NetworkManager.shared.getImageWithCaching(url: url) { (image, error) in
                    if let error = error {
                        return
                    }
                    DispatchQueue.main.async {
                        headerView.profileImageView.image = image
                    }
                }
                headerView.userAgeLabel.text = userInfos.userAge
                headerView.userNameLabel.text = userInfos.userName
           
                downArrowImageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
                downArrowImageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
                downArrowImageView.centerYAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -10).isActive = true
                downArrowImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -32).isActive = true
  
            return headerView
                
            } else if section == 1 {
                planHeaderView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: detailPlanAndLikesHeaderId, for: indexPath) as? PlanAndLikesCollectionReusableView
                
                
                guard let headerView = planHeaderView else {
                    return UICollectionReusableView.init()
                    
                }
                headerView.planLabel.text = string
                return headerView
            }
        case UICollectionView.elementKindSectionFooter:
            if section == 1 {
                guard let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: detailInfoFooterId, for: indexPath) as? PartnerDetailBottomView else {
                    return UICollectionReusableView.init()
                }
                footerView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
            let size: CGSize = CGSize(width: view.frame.width, height: 250)
            let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedForm = NSString(string: string).boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)], context: nil)
            
            return .init(width: view.frame.width, height: estimatedForm.height+10)
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
        let size: CGSize = CGSize(width: view.frame.width, height: 250)
        let option = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedForm = NSString(string: "[MC] System group container for systemgroup.com.apple.configurationprofiles path is /Users/bum/Library/Developer/CoreSimulator/Devices/A8D1299C-F22A-4416-B4EF-19144E22EB48/data/Containers/Shared/SystemGroup/systemgroup.com.apple.configurationprofiles").boundingRect(with: size, options: option, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
        
        return .init(width: view.frame.width - 2 * padding, height: estimatedForm.height)
    }

    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffSetY = scrollView.contentOffset.y
        if contentOffSetY > 0 {
            profileHeaderView?.animator.fractionComplete = 0
            return
        }
        print(contentOffSetY)
        
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
            return 7
        default:
            return 1
        }
        
    }
    
}




    /*func UISetUp() {
        self.tableView.addGestureRecognizer(panGesture)
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        headerView = setHeaderView()
        tableView.tableHeaderView = nil
        tableView.addSubview(headerView)
        
        tableView.contentInset = UIEdgeInsets(top: tableHeaderViewHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -tableHeaderViewHeight + 64)
        
        let effectiveHeight = tableHeaderViewHeight - tableHeaderViewCutaway/2
        tableView.contentInset = UIEdgeInsets(top: effectiveHeight, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -effectiveHeight)
        
        updateHeaderView()
*/
    /*
    func setHeaderView() -> UIView {
        let headerView = UIView()
        
        headerView.addSubview(self.profileImageView)
        
        NSLayoutConstraint.activate([
            self.profileImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            self.profileImageView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            self.profileImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            self.profileImageView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor)
            ])
        
        return headerView
    }
    */
    
    /*
    func updateHeaderView() {
        let effectiveHeight = tableHeaderViewHeight - tableHeaderViewCutaway/2
        
        var headerRect = CGRect(x: 0, y: -effectiveHeight, width: tableView.bounds.width, height: tableHeaderViewHeight)
        
        if tableView.contentOffset.y < effectiveHeight {
            headerRect.origin.y = tableView.contentOffset.y
            headerRect.size.height = -tableView.contentOffset.y + tableHeaderViewCutaway/2
        }
        
        headerView.frame = headerRect
    }
    
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        var startLocation = 0
        var endLocation = 0
        
        switch sender.state {
        case .began:
            startLocation = Int(sender.location(in: self.tableView).y)
        case .ended:
            endLocation = Int(sender.location(in: self.tableView).y)
            let totalMovement = endLocation - startLocation
            print("start: \(startLocation), end: \(endLocation), total: \(totalMovement)")
            if totalMovement > 50 {
                dismiss(animated: true, completion: nil)
            }
        default:
            break
        }
    }
    */
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        print(startLocation)
//        self.startLocation = Int(touch.location(in: self.view).y)
//    }
//
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let touch = touches.first else { return }
//        print(endLocation)
//        self.endLocation = Int(touch.location(in: self.view).y)
//    }

/*
extension PartnerDetailInfoViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PartnerDetailTableViewCell = PartnerDetailTableViewCell()
        
        return cell
    }
}

extension PartnerDetailInfoViewController {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
}

extension PartnerDetailInfoViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

*/
