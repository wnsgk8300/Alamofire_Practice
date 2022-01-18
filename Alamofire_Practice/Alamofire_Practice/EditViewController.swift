//
//  EditViewController.swift
//  Alamofire_Practice
//
//  Created by photypeta-junha on 2022/01/17.
//

import UIKit
import SnapKit
import Alamofire

struct MemberDataModel: Codable {
    let name: String
    let mobile: String
    let postalNumber: String
    let defaultAddress: String
    let detailAddress: String
}

class EditViewController: UIViewController {
    
    let infoLabel = UILabel()
    let nameLabel = UILabel()
    let nameButton = UIButton()
    let mobileLabel = UILabel()
    let mobileButton = UIButton()
    let zipCodeButton = UIButton()
    let addressInfoLabel = UILabel()
    let addressLabel = UILabel()
    let defaultAddressButton = UIButton()
    let detailAddressTextField = UITextField()
    let addressSearchButton = UIButton()
    let editButton = UIButton()
    let line = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        view.backgroundColor = .systemBackground
    }
}

extension EditViewController {
    @objc
    func tapInfoButton(_ sender: UIButton) {
        print(#function)
        let vc = EditDetailViewController()
        let newNaviController = UINavigationController(rootViewController: vc)
        newNaviController.modalPresentationStyle = .fullScreen
        newNaviController.setNavigationBarHidden(false, animated: false)
        switch sender {
        case nameButton:
            vc.title = "이름"
            vc.label.text = "이름이다"
            vc.textField.placeholder = "이름을 입력하세요"
            vc.Key = "name"
        case mobileButton:
            vc.title = "휴대폰 번호"
            vc.label.text = "휴대폰 번호"
            vc.textField.placeholder = "11자리 숫자를 입력하세요"
            vc.Key = "mobile"
        default:
                break
        }
        self.present(newNaviController, animated: true)
    }
}

extension EditViewController {
    func setUI() {
        setDetails()
        setLayout()
    }
    func setDetails() {
        [nameLabel, mobileLabel, addressLabel].forEach {
            $0.textColor = .gray
            $0.font = UIFont.systemFont(ofSize: 14)
        }
        [nameButton, mobileButton, zipCodeButton, defaultAddressButton].forEach {
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            $0.contentHorizontalAlignment = .left
            $0.setTitleColor(.lightGray, for: .normal)
        }
        [nameButton, mobileButton].forEach {
            $0.addTarget(self, action: #selector(tapInfoButton(_:)), for: .touchUpInside)
        }
        detailAddressTextField.font = UIFont.systemFont(ofSize: 12)
        [infoLabel, addressInfoLabel].forEach {
            $0.textColor = .label
        }
        infoLabel.text = "기본 정보"
        addressInfoLabel.text = "배송지"
        
        nameLabel.text = "이름"
        mobileLabel.text = "휴대폰 번호"
        addressLabel.text = "기본 배송지"
        
        nameButton.setTitle("이름", for: .normal)
        mobileButton.setTitle("01000000000", for: .normal)
        zipCodeButton.setTitle("우편번호", for: .normal)
        defaultAddressButton.setTitle("기본주소", for: .normal)
        detailAddressTextField.placeholder = "상세주소"
        
        [editButton, addressSearchButton].forEach {
            $0.layer.cornerRadius = 16
        }
        
        addressSearchButton.setTitle("주소 검색", for: .normal)
        addressSearchButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        addressSearchButton.backgroundColor = .lightGray
        
        editButton.setTitle("변경하기", for: .normal)
        editButton.backgroundColor = .systemBackground
        editButton.titleLabel?.textColor = .label
        editButton.layer.borderWidth = 1
        editButton.layer.borderColor = UIColor.lightGray.cgColor
        editButton.setTitleColor(.lightGray, for: .normal)
        editButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        
        line.layer.backgroundColor = UIColor.lightGray.cgColor
        line.layer.borderWidth = 10
    }
    func setLayout() {
        let labelTop = 16
        let textFieldLeading = 20
        
        [infoLabel, addressInfoLabel, nameLabel, nameButton, mobileLabel, mobileButton, addressLabel, zipCodeButton, defaultAddressButton, addressSearchButton, detailAddressTextField, editButton, line].forEach {
            view.addSubview($0)
        }
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.leading.equalToSuperview().inset(40)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(40)
            $0.top.equalTo(infoLabel.snp.bottom).offset(20)
            $0.width.equalTo(80)
        }
        nameButton.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(textFieldLeading)
            $0.centerY.equalTo(nameLabel)
            $0.trailing.equalToSuperview().inset(40)
        }
        mobileLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(labelTop)
            $0.width.equalTo(nameLabel)
        }
        mobileButton.snp.makeConstraints {
            $0.leading.equalTo(nameButton)
            $0.centerY.equalTo(mobileLabel)
            $0.trailing.equalTo(nameButton)
        }
        line.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(mobileButton.snp.bottom).offset(20)
//            $0.height.equalTo(1)
        }
        addressInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(infoLabel)
            $0.top.equalTo(line.snp.bottom).offset(20)
        }
        addressLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.top.equalTo(addressInfoLabel.snp.bottom).offset(labelTop)
            $0.width.equalTo(nameLabel)
        }
        zipCodeButton.snp.makeConstraints {
            $0.leading.equalTo(nameButton)
            $0.centerY.equalTo(addressLabel)
            $0.trailing.equalTo(addressSearchButton.snp.leading).offset(20)
        }
        addressSearchButton.snp.makeConstraints {
            $0.centerY.equalTo(zipCodeButton)
            $0.trailing.equalToSuperview().inset(40)
            $0.width.equalTo(80)
        }
        defaultAddressButton.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(textFieldLeading)
            $0.top.equalTo(zipCodeButton.snp.bottom).offset(8)
            $0.trailing.equalTo(nameButton)
        }
        detailAddressTextField.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(textFieldLeading)
            $0.top.equalTo(defaultAddressButton.snp.bottom).offset(8)
            $0.trailing.equalTo(nameButton)
        }
        editButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(detailAddressTextField.snp.bottom).offset(20)
            $0.width.equalTo(140)
            $0.height.equalTo(40)
        }
    }
}
