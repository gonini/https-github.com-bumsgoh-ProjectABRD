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
        //        tableView.backgroundColor = #colorLiteral(red: 0.9504646659, green: 0.9448142648, blue: 0.9548078179, alpha: 1)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myPageTableView.delegate = self
        self.myPageTableView.dataSource = self
        setLayout()
    }
    
    func setLayout() {
        //        let button = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        //
        //        self.navigationController?.navigationItem.rightBarButtonItem = button
        
        self.view.addSubview(myPageTableView)
        
        NSLayoutConstraint.activate([
            myPageTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            myPageTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            myPageTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            myPageTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
    }
}

extension MyPageViewController: UITableViewDelegate {
}

extension MyPageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell: myPageProfileTableViewCell = myPageProfileTableViewCell()
            cell.nameLabel.text = "상순이"
            cell.isUserInteractionEnabled = false
            return cell
        case 1:
            let cell: myPageTravelingTableViewCell = myPageTravelingTableViewCell()
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

class myPageProfileTableViewCell: UITableViewCell {
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
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    func setLayout() {
        self.contentView.backgroundColor = #colorLiteral(red: 0.9504646659, green: 0.9448142648, blue: 0.9548078179, alpha: 1)
        
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            self.contentView.heightAnchor.constraint(equalToConstant: 200),
            
            profileImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: -20),
            profileImageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            
            nameLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class myPageTravelingTableViewCell: UITableViewCell {
    let travelSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.isUserInteractionEnabled = false
        return slider
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    func setLayout() {
        self.contentView.addSubview(travelSlider)
        
        NSLayoutConstraint.activate([
            travelSlider.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            travelSlider.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20),
            travelSlider.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20)
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
        label.textColor = .gray
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
        label.textColor = .gray
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
