//
//  myPageSettingViewController.swift
//  AbroadApp
//
//  Created by 이혜주 on 26/10/2018.
//  Copyright © 2018 고상범. All rights reserved.
//

import UIKit

class MyPageSettingViewController: UIViewController {

    //키보드 내릴것
    let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer()
    
    lazy var tapImageView = UITapGestureRecognizer(target: self, action: #selector(touchUpProfileImageView(_:)))
    
    let imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        return picker
    }()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.0
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "IMG_0596")
        imageView.layer.cornerRadius = 45
        return imageView
    }()
    
    lazy var saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(touchUpSaveBarButton(_:)))
    
    let settingMyPageTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var maleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" 🧑🏻 ", for: .normal)
        button.layer.borderWidth = 2.5
        button.layer.borderColor = #colorLiteral(red: 0.9169242978, green: 0.9114735723, blue: 0.9211141467, alpha: 1).cgColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(touchUpMaleButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var femaleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(" 👩🏻 ", for: .normal)
        button.layer.borderWidth = 2.5
        button.layer.borderColor = #colorLiteral(red: 0.9169242978, green: 0.9114735723, blue: 0.9211141467, alpha: 1).cgColor
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(touchUpFemaleButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.settingMyPageTableView.delegate = self
        self.settingMyPageTableView.dataSource = self
        self.tapGesture.delegate = self
        self.tapImageView.delegate = self
        self.imagePicker.delegate = self
        setLayout()
    }
    
    func setLayout() {
        self.view.backgroundColor = .white
        self.navigationItem.title = "프로필 관리"
        self.settingMyPageTableView.tableHeaderView = setHeaderView()
        
        self.navigationItem.rightBarButtonItem = saveButton
        
        self.view.addSubview(settingMyPageTableView)
        
        self.view.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            settingMyPageTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            settingMyPageTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            settingMyPageTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            settingMyPageTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 200))
        
        let nameTextField: UITextField = {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.font = .boldSystemFont(ofSize: 18)
            textField.text = "상순이"
            textField.placeholder = "이름"
            return textField
        }()
        
        headerView.backgroundColor = #colorLiteral(red: 0.9504646659, green: 0.9448142648, blue: 0.9548078179, alpha: 1)
            
        headerView.addSubview(profileImageView)
        headerView.addSubview(nameTextField)
        profileImageView.addGestureRecognizer(tapImageView)
        
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: -20),
            profileImageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.5),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor),
            
            nameTextField.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            nameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20)
            ])
        
        return headerView
    }
    
    func setSelectSexInfoCell() -> UITableViewCell {
        let tableViewCell = UITableViewCell()
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = .boldSystemFont(ofSize: 18)
            label.text = "성별"
            return label
        }()
        
        let buttonStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.spacing = 5
            stackView.addArrangedSubview(maleButton)
            stackView.addArrangedSubview(femaleButton)
            return stackView
        }()
        
        tableViewCell.addSubview(titleLabel)
        tableViewCell.addSubview(buttonStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: tableViewCell.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: tableViewCell.leadingAnchor, constant: 15),
            
            buttonStackView.centerYAnchor.constraint(equalTo: tableViewCell.centerYAnchor),
            buttonStackView.trailingAnchor.constraint(equalTo: tableViewCell.trailingAnchor, constant: -15)
            ])
        
        return tableViewCell
    }
    
    
    @objc func touchUpMaleButton(_ sender: UIButton) {
        if sender.layer.borderColor == #colorLiteral(red: 0.9169242978, green: 0.9114735723, blue: 0.9211141467, alpha: 1).cgColor {
            sender.layer.borderColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).cgColor
            sender.isSelected = true
            self.femaleButton.layer.borderColor = #colorLiteral(red: 0.9169242978, green: 0.9114735723, blue: 0.9211141467, alpha: 1).cgColor
            self.femaleButton.isSelected = false
        }
    }
    
    
    @objc func touchUpFemaleButton(_ sender: UIButton) {
        if sender.layer.borderColor == #colorLiteral(red: 0.9169242978, green: 0.9114735723, blue: 0.9211141467, alpha: 1).cgColor {
            sender.layer.borderColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).cgColor
            sender.isSelected = true
            self.maleButton.layer.borderColor = #colorLiteral(red: 0.9169242978, green: 0.9114735723, blue: 0.9211141467, alpha: 1).cgColor
            self.maleButton.isSelected = false
        }
    }
    
    @objc func touchUpSaveBarButton(_: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func touchUpProfileImageView(_: UIImageView) {
        self.present(self.imagePicker, animated: true, completion: nil)
    }

}

extension MyPageSettingViewController: UITableViewDelegate {}

extension MyPageSettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell: UITableViewCell = UITableViewCell()
            cell.textLabel?.text = "여행기간설정"
            cell.textLabel?.font = .boldSystemFont(ofSize: 18)
            cell.accessoryType = .disclosureIndicator
            return cell
        case 1:
            let cell: UITableViewCell = setSelectSexInfoCell()
//            cell.titleLabel.text = "성별"
//            cell.isUserInteractionEnabled = false
            return cell
        case 2:
            let cell: settingMyPageTableViewCell = settingMyPageTableViewCell()
            cell.titleLabel.text = "나이"
            cell.dataTextField.placeholder = "나이를 입력해주세요"
//            cell.isUserInteractionEnabled = false
            return cell
        case 3:
            let cell: settingMyPageTableViewCell = settingMyPageTableViewCell()
            cell.titleLabel.text = "출신국가"
            cell.dataTextField.placeholder = "출신국가를 선택해주세요"
//            cell.isUserInteractionEnabled = false
            return cell
        case 4:
            let cell: settingMyPageTableViewCell = settingMyPageTableViewCell()
            cell.titleLabel.text = "여행 목적"
            cell.dataTextField.placeholder = "여행 목적을 입력해주세요"
//            cell.isUserInteractionEnabled = false
            return cell
        case 5:
            let cell: settingMyPageIntroduceTableViewCell = settingMyPageIntroduceTableViewCell()
            cell.titleLabel.text = "소개"
//            cell.isUserInteractionEnabled = false
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MyPageSettingViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
}

extension MyPageSettingViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let editImage = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage {
            self.profileImageView.image = editImage
        } else if let originalImage: UIImage = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage {
            self.profileImageView.image = originalImage
        }
        
         self.dismiss(animated: true, completion: nil)
    }
}

extension MyPageSettingViewController: UINavigationControllerDelegate {}

// 나이, 출신국가, 여행목적 셀
class settingMyPageTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let dataTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    func setLayout() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(dataTextField)
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            
            dataTextField.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            dataTextField.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class settingMyPageIntroduceTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    let dataTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "소개를 입력해주세요"
        textView.textColor = #colorLiteral(red: 0.8781575561, green: 0.8822220564, blue: 0.89215523, alpha: 1)
        textView.font = .systemFont(ofSize: 18)
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.dataTextView.delegate = self
        setLayout()
    }
    
    func setLayout() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(dataTextView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            
            dataTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            dataTextView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 15),
            dataTextView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -15),
            dataTextView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15),
            dataTextView.heightAnchor.constraint(equalToConstant: 200)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension settingMyPageIntroduceTableViewCell: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textView.text = ""
        textView.textColor = .black
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "소개를 입력해주세요"
            textView.textColor = #colorLiteral(red: 0.8781575561, green: 0.8822220564, blue: 0.89215523, alpha: 1)
        }
    }
}
