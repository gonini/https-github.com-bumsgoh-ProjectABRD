//
//  CountrySelectingCollectionViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 9. 17..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CountrySelectingCell"

// 나라 선택 화면
class CountrySelectingCollectionViewController: UIViewController {
    var width: CGFloat?
    var imageViewArray = [UIImage]()
    var countryName: [String] = []
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "어떤 나라를 여행하시나요?"
        return label
    }()
    
    let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let countryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view: UICollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
       
        view.collectionViewLayout = layout
        view.setCollectionViewLayout(layout, animated: true)
      
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        countryCollectionView.collectionViewLayout = layout
        countryCollectionView.setCollectionViewLayout(layout, animated: true)
        countryCollectionView.register(CountrySelectingCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        self.view.backgroundColor = UIColor.white
        if #available(iOS 11.0, *) {
            countryCollectionView.contentInsetAdjustmentBehavior = .always
        }
        if UIDevice.current.orientation.isPortrait == true {
            width = UIScreen.main.bounds.width
        } else {
            width = UIScreen.main.bounds.height
        }
        countryCollectionView.backgroundColor = UIColor.white
        
        imageViewArray.append(#imageLiteral(resourceName: "badshahi-mosque"))
        imageViewArray.append(#imageLiteral(resourceName: "christ-the-redeemer"))
        imageViewArray.append(#imageLiteral(resourceName: "eiffel-tower"))
        imageViewArray.append(#imageLiteral(resourceName: "statue-of-liberty"))
        imageViewArray.append(#imageLiteral(resourceName: "sydney-opera-house"))
        imageViewArray.append(#imageLiteral(resourceName: "taj-mahal"))
        
        countryName = ["아시아", "남미", "유럽", "미국", "호주", "중동"]
        
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
        UISetUP()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        animateTable()
    }
    
    func UISetUP() {
        self.view.addSubview(headerView)
        self.headerView.addSubview(countryLabel)
        self.view.addSubview(countryCollectionView)
        
        
        self.headerView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        self.headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.headerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.headerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        self.countryLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        self.countryLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        
        self.countryCollectionView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor).isActive = true
        self.countryCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        self.countryCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        self.countryCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

extension CountrySelectingCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 6
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CountrySelectingCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CountrySelectingCollectionViewCell
        cell.backgroundColor = UIColor.white
        cell.thumbNailImageView.image = imageViewArray[indexPath.row]
        cell.titleLabel.text = countryName[indexPath.row]
        cell.layer.addShadow()
        cell.layer.roundCorners(radius: 10)
        /*
         cell.contentView.layer.cornerRadius = 2.0
         cell.contentView.layer.borderWidth = 1.0
         cell.contentView.layer.borderColor = UIColor.clear.cgColor
         cell.contentView.layer.masksToBounds = true;
         
         cell.layer.shadowColor = UIColor.white.cgColor
         cell.layer.shadowOffset = CGSize(width:0,height: 2.0)
         cell.layer.shadowRadius = 2.0
         cell.layer.shadowOpacity = 1.0
         cell.layer.masksToBounds = false;
         cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath*/
        // Configure the cell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.countryLabel.text = countryName[indexPath.row]
        let VC = MainTabBarController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
}

extension CountrySelectingCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let width = self.width else {return CGSize.init()}
        return CGSize(width: width/2 - 32, height: width/2 - 16 )
    }
}
extension CALayer {
    func addShadow() {
        self.shadowOffset = .zero
        self.shadowOpacity = 0.1
        self.shadowRadius = 5
        self.shadowColor = UIColor.black.cgColor
        self.masksToBounds = false
    }
    
    func roundCorners(radius: CGFloat) {
        self.cornerRadius = radius
    }
}

extension CountrySelectingCollectionViewController {
    func animateTable() {
        countryCollectionView.reloadData()
        
        let cells = countryCollectionView.visibleCells
        let tableHeight: CGFloat = countryCollectionView.bounds.size.height
        
        for i in cells {
            let cell: CountrySelectingCollectionViewCell = i as! CountrySelectingCollectionViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: CountrySelectingCollectionViewCell = a as! CountrySelectingCollectionViewCell
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            
            index += 1
        }
    }
}

