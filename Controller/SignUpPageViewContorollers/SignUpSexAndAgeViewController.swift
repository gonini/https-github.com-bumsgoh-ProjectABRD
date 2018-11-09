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
    
    var selectedCountry: String?
    var selectedAge: String?
    
    let ageArray: [String] = {
        var arr: [String] = []
        for i in 19...50 {
        arr.append(String("\(i) 세"))
        }
        return arr
    }()
    
    let countryList: [String] = [
        "Australia",
        "China",
        "Germany",
        "India",
        "Japan",
        "Korea",
        "Russia",
        "USA",
        "UK"
    ]
    
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
        button.setImage(UIImage(named: "manUnselected"), for: .normal)
        return button
    }()
    
    let femaleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "womanUnselected"), for: .normal)
        return button
    }()
    
    let sexStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 50
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
    
    let ageSelectTextField: NoCursurTextField = {
        let textField = NoCursurTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "나이"
        textField.font = .systemFont(ofSize: 20)
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.textColor = .darkGray
        return textField
    }()
    
    let agePickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return picker
    }()

    let nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("확인", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1), for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.borderColor = #colorLiteral(red: 0.5725490451, green: 0, blue: 0.2313725501, alpha: 1).cgColor
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2.0
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("취소", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1), for: .normal)
        button.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 20
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
    
    let countryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "출신국가를 선택해주세요"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    let countrySelectTextField: NoCursurTextField = {
        let textField = NoCursurTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "출신국가"
        textField.font = .systemFont(ofSize: 20)
        textField.textAlignment = .center
        textField.textColor = .darkGray
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let countryPickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return pickerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        self.agePickerView.delegate = self
        self.agePickerView.dataSource = self
        self.countryPickerView.delegate = self
        
        UISetUp()
        createToolbar()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(nextButtonClicked(sender:)))
    }
    
    @objc func nextButtonClicked(sender: UIBarButtonItem) {
        let vc: CountrySelectingCollectionViewController = CountrySelectingCollectionViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func UISetUp() {
        self.countrySelectTextField.inputView = countryPickerView
        self.ageSelectTextField.inputView = agePickerView
        
        self.view.addSubview(sexLabel)
        self.view.addSubview(sexStackView)
        
        self.buttonStackView.addArrangedSubview(backButton)
        self.buttonStackView.addArrangedSubview(nextButton)
        
        self.sexStackView.addArrangedSubview(femaleButton)
        self.sexStackView.addArrangedSubview(maleButton)
        
        self.view.addSubview(ageLabel)
        self.view.addSubview(ageSelectTextField)
        self.view.addSubview(countryLabel)
        self.view.addSubview(countrySelectTextField)
        self.view.addSubview(buttonStackView)
        
        self.backButton.addTarget(self, action: #selector(touchUpCancelButton(_:)), for: .touchUpInside)
        self.nextButton.addTarget(self, action: #selector(touchUpNextButton(_:)), for: .touchUpInside)
        
        maleButton.addTarget(self, action: #selector(maleImageClicked(_:)), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(femaleImageClicked(_:)), for: .touchUpInside)
        
        self.sexLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        self.sexLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        
        self.sexStackView.topAnchor.constraint(equalTo: self.sexLabel.bottomAnchor, constant: 24).isActive = true
        self.sexStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.sexStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 80).isActive = true
        self.sexStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -80).isActive = true
        self.sexStackView.heightAnchor.constraint(equalTo: self.sexStackView.widthAnchor, multiplier: 0.4).isActive = true
        
        self.ageLabel.topAnchor.constraint(equalTo: self.sexStackView.bottomAnchor, constant: 50).isActive = true
        self.ageLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        
        self.ageSelectTextField.topAnchor.constraint(equalTo: self.ageLabel.bottomAnchor, constant: 20).isActive = true
        self.ageSelectTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.ageSelectTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        self.ageSelectTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        
        self.countryLabel.topAnchor.constraint(equalTo: self.ageSelectTextField.bottomAnchor, constant: 50).isActive = true
        self.countryLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30).isActive = true
        
        self.countrySelectTextField.topAnchor.constraint(equalTo: self.countryLabel.bottomAnchor, constant: 15).isActive = true
        self.countrySelectTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.countrySelectTextField.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        self.countrySelectTextField.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        
//        self.buttonStackView.topAnchor.constraint(equalTo: self.countrySelectTextField.bottomAnchor, constant: 100).isActive = true
        self.buttonStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        self.buttonStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        self.buttonStackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.buttonStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -60).isActive = true
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        toolBar.backgroundColor = .lightGray
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissKeyboard(_:)))
        
        doneButton.tintColor = .darkGray
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        self.countrySelectTextField.inputAccessoryView = toolBar
        self.ageSelectTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard(_: UIBarButtonItem) {
        view.endEditing(true)
    }
    
    @objc func femaleImageClicked(_ sender: UIButton) {
        guard let stackViewWoman: UIButton = sexStackView.arrangedSubviews[0] as? UIButton else { return }
        guard let stackViewMan: UIButton = sexStackView.arrangedSubviews[1] as? UIButton else { return }
        if stackViewWoman.imageView?.image == UIImage(named: "womanUnselected") {
            stackViewWoman.setImage(UIImage(named: "woman"), for: .normal)
            stackViewMan.setImage(UIImage(named: "manUnselected"), for: .normal)
        }
        self.isFemale = true
    }
    
    @objc func maleImageClicked(_ sender: UIButton) {
        guard let stackViewWoman: UIButton = sexStackView.arrangedSubviews[0] as? UIButton else { return }
        guard let stackViewMan: UIButton = sexStackView.arrangedSubviews[1] as? UIButton else { return }
        if stackViewMan.imageView?.image == UIImage(named: "manUnselected") {
            stackViewMan.setImage(UIImage(named: "man"), for: .normal)
            stackViewWoman.setImage(UIImage(named: "womanUnselected"), for: .normal)
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
        if pickerView == agePickerView {
            return ageArray.count
        } else {
            return countryList.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == agePickerView {
            return ageArray[row]
        } else {
            return countryList[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == agePickerView {
            selectedAge = ageArray[row]
            ageSelectTextField.text = selectedAge
        } else {
            selectedCountry = countryList[row]
            countrySelectTextField.text = selectedCountry
        }
    }
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        var label: UILabel
//
//        if let view = view as? UILabel {
//            label = view
//        } else {
//            label = UILabel()
//        }
//
//        label.textColor = .darkGray
//        label.textAlignment = .center
//        label.font = UIFont(name: "Menlo-Regular", size: 17)
//
//        label.text = ageArray[row]
//
//        return label
//    }
}

extension SignUpSexAndAgeViewController: UIGestureRecognizerDelegate {}
