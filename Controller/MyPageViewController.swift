//
//  MyPageViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 6..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {
    
    let myPageTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let settingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "gear"), for: .normal)
        button.addTarget(self, action: #selector(touchUpSettingButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myPageTableView.delegate = self
        self.myPageTableView.dataSource = self
        setLayout()
    }
    
    func setLayout() {
        self.view.backgroundColor = .white
        self.myPageTableView.tableHeaderView = setHeaderView()
        
        self.view.addSubview(myPageTableView)
        
        NSLayoutConstraint.activate([
            myPageTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            myPageTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            myPageTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            myPageTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    @objc func touchUpSettingButton(_: UIButton) {
        let settingViewController: MyPageSettingViewController = MyPageSettingViewController()
        
        self.navigationController?.pushViewController(settingViewController, animated: true)
    }
    
    func setHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        headerView.backgroundColor = #colorLiteral(red: 0.9504646659, green: 0.9448142648, blue: 0.9548078179, alpha: 1)
        
        let profileImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.layer.borderWidth = 1.0
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.image = UIImage(named: "IMG_0596")
            imageView.layer.cornerRadius = 45
            imageView.isUserInteractionEnabled = true
            return imageView
        }()
        
        let nameLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .boldSystemFont(ofSize: 18)
            label.text = "상순이"
            return label
        }()
        
        headerView.addSubview(profileImageView)
        headerView.addSubview(nameLabel)
        headerView.addSubview(settingButton)
        
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -20),
            profileImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.5),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            
            nameLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            
            settingButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
            settingButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            settingButton.heightAnchor.constraint(equalToConstant: 25),
            settingButton.widthAnchor.constraint(equalToConstant: 25)
            ])
        
        return headerView
    }
}

extension MyPageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell: myPageTravelingTableViewCell = myPageTravelingTableViewCell()
            cell.isUserInteractionEnabled = false
            return cell
        case 1:
            let cell: myPageTableViewCell = myPageTableViewCell()
            cell.titleLabel.text = "성별"
            // 이미지??
            cell.dataLabel.text = "👩🏻"
            cell.isUserInteractionEnabled = false
            return cell
        case 2:
            let cell: myPageTableViewCell = myPageTableViewCell()
            cell.titleLabel.text = "나이"
            cell.dataLabel.text = "나이를 입력해주세요"
            cell.isUserInteractionEnabled = false
            return cell
        case 3:
            let cell: myPageTableViewCell = myPageTableViewCell()
            cell.titleLabel.text = "출신국가"
            cell.dataLabel.text = "출신국가를 선택해주세요"
            cell.isUserInteractionEnabled = false
            return cell
        case 4:
            let cell: myPageTableViewCell = myPageTableViewCell()
            cell.titleLabel.text = "여행 목적"
            cell.dataLabel.text = "여행 목적을 입력해주세요"
            cell.isUserInteractionEnabled = false
            return cell
        case 5:
            let cell: myPageIntroduceTableViewCell = myPageIntroduceTableViewCell()
            cell.titleLabel.text = "소개"
            cell.dataLabel.text = "소개를 입력해주세요"
            cell.isUserInteractionEnabled = false
            return cell
        default:
            return UITableViewCell()
        }
    }
}

class myPageTravelingTableViewCell: UITableViewCell {
    
    let travelView = myPageTravelView()
    let currentTravelView = myPageCurrentTravelView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    func setLayout() {
        
        travelView.translatesAutoresizingMaskIntoConstraints = false
        currentTravelView.translatesAutoresizingMaskIntoConstraints = false
        
        travelView.backgroundColor = .white
        currentTravelView.backgroundColor = .clear
        
        self.contentView.addSubview(travelView)
        self.contentView.addSubview(currentTravelView)
        
        NSLayoutConstraint.activate([
            travelView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            travelView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            travelView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            travelView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            currentTravelView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            currentTravelView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            currentTravelView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            currentTravelView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class myPageTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    func setLayout() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(dataLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            
            dataLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            dataLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class myPageIntroduceTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .lightGray
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    func setLayout() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(dataLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            
            dataLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dataLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            dataLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            dataLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
