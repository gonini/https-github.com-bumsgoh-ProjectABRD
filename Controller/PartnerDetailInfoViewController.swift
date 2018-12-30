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
    fileprivate let padding: CGFloat = 16
    
    var headerView: PartnerDetailHeaderReusableView?
    /*
    lazy var panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
    
    private let tableHeaderViewHeight: CGFloat = 400.0
    private let tableHeaderViewCutaway: CGFloat = 0.0
    
    var headerView: UIView!
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "IMG_0596")
        return imageView
    }()
    */
   
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        setUpCollectionViewLayout()
        
    }
    
    
    fileprivate func setUpCollectionViewLayout() {
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        }
    }
    
    fileprivate func setUpCollectionView() {
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInsetAdjustmentBehavior = .never
        
        collectionView.register(PartnerDetailInfoCollectionViewCell.self, forCellWithReuseIdentifier: detailInfoCellId)
        
        collectionView.register(PartnerDetailHeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: detailInfoHeaderId)
    }
    
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailInfoCellId, for: indexPath)
        cell.backgroundColor = .black
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: detailInfoHeaderId, for: indexPath) as? PartnerDetailHeaderReusableView
        
        guard let headerView = headerView else {
            return UICollectionReusableView.init()
            
        }
        return headerView
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return .init(width: view.frame.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 2 * padding, height: 50)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffSetY = scrollView.contentOffset.y
        if contentOffSetY > 0 {
            headerView?.animator.fractionComplete = 0
            return
        }
        headerView?.animator.fractionComplete = abs(contentOffSetY) / 100
        
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
