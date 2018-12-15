//
//  PartnerDetailInfoViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 6..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class PartnerDetailInfoViewController: UITableViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.panGesture.delegate = self
        UISetUp()
        self.view.backgroundColor = UIColor.white
        //self.view.alpha = 0.3
        
    }
    
    func UISetUp() {
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
    }
    
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
}

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

class PartnerDetailTableViewCell: UITableViewCell {
    
    let memberNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.text = "고상범"
        return label
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.text = "25"
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "🇰🇷"
        label.font = .systemFont(ofSize: 30)
        return label
    }()
    
    let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    let tripPlanLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .darkGray
        label.text = "독일에서 3일 프랑크푸르트에 숙박예정, 이후에 뮌헨으로 가서 4일동안 구경하고 호프브로이 하우스 관광예정입니다."
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        UISetUp()
    }
    
    func UISetUp() {
        titleStackView.addArrangedSubview(memberNameLabel)
        titleStackView.addArrangedSubview(ageLabel)
//        titleStackView.addArrangedSubview(countryLabel)
        
        self.contentView.addSubview(titleStackView)
        self.contentView.addSubview(tripPlanLabel)
        
        NSLayoutConstraint.activate([
            self.contentView.heightAnchor.constraint(equalToConstant: 350),
            
            titleStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
            titleStackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            
            tripPlanLabel.topAnchor.constraint(equalTo: memberNameLabel.bottomAnchor, constant: 25),
            tripPlanLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            tripPlanLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
