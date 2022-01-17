//
//  EditProfileViewController.swift
//  Alamofire_Practice
//
//  Created by photypeta-junha on 2022/01/17.
//

import UIKit
import SnapKit
import Alamofire

class EditProfileViewController: UIViewController {
    
    let nameLabel = UILabel()
    let nameTextField = UITextField()
    let mobileLabel = UILabel()
    let mobileTextField = UITextField()
    let zipCodeTextField = UITextField()
    let addressLabel = UILabel()
    let address1TextField = UITextField()
    let address2TextField = UITextField()
    let addressSearchButton = UIButton()
    let editButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        view.backgroundColor = .systemBackground
    }
}

extension EditProfileViewController {
    func setUI() {
        setDetails()
        setLayout()
    }
    func setDetails() {
        [nameLabel, mobileLabel, addressLabel].forEach {
            $0.textColor = .gray
            $0.font = UIFont.systemFont(ofSize: 8)
        }
        nameLabel.text = "이름"
        mobileLabel.text = "휴대폰 번호"
        addressLabel.text = "기본 배송지"
        nameTextField.placeholder = "이름"
        mobileTextField.placeholder = "01000000000"
        zipCodeTextField.placeholder = "우편번호"
        address1TextField.placeholder = "기본주소"
        address2TextField.placeholder = "상세주소"
        editButton.setTitle("변경하기", for: .normal)
        
    }
    func setLayout() {
        let labelTop = 20
        
        [nameLabel, nameTextField, mobileLabel, mobileTextField, addressLabel, zipCodeTextField, address1TextField, address2TextField, editButton].forEach {
            view.addSubview($0)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
        nameTextField.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(40)
            $0.centerY.equalTo(nameLabel)
        }
        mobileLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(labelTop)
        }
        mobileTextField.snp.makeConstraints {
            $0.leading.equalTo(nameTextField)
            $0.centerY.equalTo(mobileLabel)
        }
        addressLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.top.equalTo(mobileLabel.snp.bottom).offset(labelTop)
        }
        zipCodeTextField.snp.makeConstraints {
            $0.leading.equalTo(nameTextField)
            $0.centerY.equalTo(addressLabel)
        }
        address1TextField.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(40)
            $0.top.equalTo(zipCodeTextField.snp.bottom).offset(8)
        }
        address2TextField.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(40)
            $0.top.equalTo(address1TextField.snp.bottom).offset(8)
        }
    }
}
