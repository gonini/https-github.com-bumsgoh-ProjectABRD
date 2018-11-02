//
//  SignUpSexViewController.swift
//  AbroadApp
//
//  Created by 고상범 on 2018. 10. 5..
//  Copyright © 2018년 고상범. All rights reserved.
//

import UIKit

// 회원가입 성별/나이 화면
class SignUpSexAndAgeViewController: UIViewController {
    
    var isFemale: Bool = true
    
    let ageArray: [String] = {
        var arr: [String] = []
        for i in 19...50 {
        arr.append(String("\(i) 세"))
        }
        return arr
    }()
    
    let sexLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "성별을 선택해주세요"
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let maleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
//        view.image = #imageLiteral(resourceName: "hairstyle-4")
        button.isUserInteractionEnabled = true
        button.layer.borderWidth = 5
        button.layer.cornerRadius = 30
        button.setTitle("Man", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.setTitleColor(.lightGray, for: .normal)
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    let femaleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
//        view.image = #imageLiteral(resourceName: "hairstyle-3")
        button.isUserInteractionEnabled = true
        button.layer.borderWidth = 5
        button.layer.cornerRadius = 30
        button.setTitle("Woman", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    let sexStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 30
        view.distribution = .fillEqually
        return view
    }()
    
    let ageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "나이를 선택해주세요"
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let agePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.numberOfRows(inComponent: 4)
        return picker
    }()

    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2.0
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.gray, for: .normal)
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.cornerRadius = 15
        button.layer.borderWidth = 2.0
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        UISetUp()
        
        agePickerView.delegate = self
        agePickerView.dataSource = self
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonClicked(sender:)))
    }
    
    @objc func nextButtonClicked(sender: UIBarButtonItem) {
        let vc: CountrySelectingCollectionViewController = CountrySelectingCollectionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func UISetUp() {
        self.view.addSubview(sexLabel)
        self.view.addSubview(sexStackView)
        
        self.buttonStackView.addArrangedSubview(backButton)
        self.buttonStackView.addArrangedSubview(nextButton)
        
        self.sexStackView.addArrangedSubview(femaleButton)
        self.sexStackView.addArrangedSubview(maleButton)
        
        self.view.addSubview(ageLabel)
        self.view.addSubview(agePickerView)
        self.view.addSubview(buttonStackView)
        
        self.backButton.addTarget(self, action: #selector(touchUpCancelButton(_:)), for: .touchUpInside)
        self.nextButton.addTarget(self, action: #selector(touchUpNextButton(_:)), for: .touchUpInside)
        
        maleButton.addTarget(self, action: #selector(maleImageClicked(_:)), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(femaleImageClicked(_:)), for: .touchUpInside)
        
        self.sexLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        self.sexLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        
        self.sexStackView.topAnchor.constraint(equalTo: self.sexLabel.bottomAnchor, constant: 24).isActive = true
        self.sexStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.femaleButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.femaleButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.maleButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        self.maleButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        self.ageLabel.topAnchor.constraint(equalTo: self.sexStackView.bottomAnchor, constant: 50).isActive = true
        self.ageLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        
        self.agePickerView.topAnchor.constraint(equalTo: self.ageLabel.bottomAnchor, constant: 10).isActive = true
        self.agePickerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.agePickerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.buttonStackView.topAnchor.constraint(equalTo: self.agePickerView.bottomAnchor, constant: 20).isActive = true
        self.buttonStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        self.buttonStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
    }
    
    @objc func femaleImageClicked(_ sender: UIButton) {
        guard let stackViewWoman: UIButton = sexStackView.arrangedSubviews[0] as? UIButton else { return }
        guard let stackViewMan: UIButton = sexStackView.arrangedSubviews[1] as? UIButton else { return }
        if stackViewWoman.layer.borderColor == UIColor.lightGray.cgColor {
            stackViewMan.layer.borderColor = UIColor.lightGray.cgColor
            stackViewMan.setTitleColor(.lightGray, for: .normal)
            stackViewWoman.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1).cgColor
            stackViewWoman.setTitleColor(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), for: .normal)
        }
        self.isFemale = true
    }
    
    @objc func maleImageClicked(_ sender: UIButton) {
        guard let stackViewWoman: UIButton = sexStackView.arrangedSubviews[0] as? UIButton else { return }
        guard let stackViewMan: UIButton = sexStackView.arrangedSubviews[1] as? UIButton else { return }
        if stackViewMan.layer.borderColor == UIColor.lightGray.cgColor  {stackViewWoman.layer.borderColor = UIColor.lightGray.cgColor
            stackViewWoman.setTitleColor(.lightGray, for: .normal)
            stackViewMan.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1).cgColor
            stackViewMan.setTitleColor(#colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1), for: .normal)
        }
        self.isFemale = false
    }

    @objc func touchUpCancelButton(_: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func touchUpNextButton(_: UIButton) {
        let vc: CountrySelectingCollectionViewController = CountrySelectingCollectionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SignUpSexAndAgeViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ageArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ageArray[row]
    }
}
