
//
//  LoadingIndicatorView.swift
//  AbroadApp
//
//  Created by bumslap on 03/01/2019.
//  Copyright © 2019 고상범. All rights reserved.
//

import UIKit

class LoadingIndicatorView: UIVisualEffectView {

    let indicatorStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 10
        //view.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //view.isLayoutMarginsRelativeArrangement = true
        return view
    }()
    
    let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.style = .gray
        return indicator
    }()
   
    let noticeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        return label
    }()
    
    init() {
        super.init(effect: UIBlurEffect(style: .light))
        UISetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func UISetUp() {
        contentView.addSubview(indicatorStackView)
        indicatorStackView.addArrangedSubview(indicator)
        indicatorStackView.addArrangedSubview(noticeLabel)
        
        indicatorStackView.centerSuperView()
        self.clipsToBounds = true
        self.layer.cornerRadius = 15
    }

    func activateIndicatorView() {
        self.isHidden = false
        indicator.startAnimating()
    }
    
    func deactivateIndicatorView() {
        self.isHidden = true
        indicator.stopAnimating()
    }
}
