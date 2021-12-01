//
//  AddressRegisterViewController.swift
//  PhotypetaPhotos
//
//  Created by photypeta-junha on 2021/10/22.
//  Copyright © 2021 Photy Peta. All rights reserved.
//

import Alamofire
import UIKit
import SnapKit

class AddressRegisterViewController: UIViewController {
    func didAddressChanged(isChanged: Bool) {
        return
    }
    
    var restoreFrameValue: CGFloat = 0.0
    let mainView = UIView()
    let mainLabel = UILabel()
    let nameLabel = UILabel()
    let nameTextfield = UITextField()
    let mobileLabel = UILabel()
    let mobileTextfield = UITextField()
    let addressLabel = UILabel()
    let zipCodeTextField = UITextField()
    let addressSearchButton = UIButton()
    let address1TextField = UITextField()
    let address2TextField = UITextField()
    let registerButton = UIButton()
    let nameLine = UIView()
    let mobileLine = UIView()
    let zipCodeLine = UIView()
    let address1Line = UIView()
    let address2Line = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.mainView.frame.origin.y = restoreFrameValue
        self.view.endEditing(true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        //        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    func tapRegisterButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "모든 정보를 입력해주세요", message: nil, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        var isFilled = true
        alert.addAction(okAction)
        
        let name = nameTextfield.text
        let mobile = mobileTextfield.text
        let zipcode = zipCodeTextField.text
        let address1 = address1TextField.text
        let address2 = address2TextField.text
        
        [name, mobile, zipcode, address1, address2].forEach {
            if $0 == nil || $0 == "" {
                isFilled = false
            }
        }
        if isFilled {

            
            let params = ["snsID": "아이디3", "name": name, "mobile": mobile, "zipcode": zipcode, "address1": address1, "address2": address2] as Dictionary
            
                    let url = "https://ptsv2.com/t/9gmtf-1637112073/post"
//            let url = "http://192.168.0.28:3000/auth/kakao"
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.timeoutInterval = 10
            
            // httpBody 에 parameters 추가
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                print("http Body Error")
            }
            
            AF.request(request).responseString { (response) in
                switch response.result {
                case .success:
                    print("POST 성공")
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
        } else {
            present(alert, animated: false, completion: nil)
        }
    }
        
        
        //        var params = ["snsID": "아이디3", "name": nameTextfield.text, "mobile":"모바일", "zipcode": "12421", "address1": "wqr", "address2": "qwr"] as Dictionary
        //
        //        //        let url = "https://ptsv2.com/t/9gmtf-1637112073/post"
        //        let url = "http://192.168.0.28:3000/auth/kakao"
        //        var request = URLRequest(url: URL(string: url)!)
        //        request.httpMethod = "POST"
        //        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //        request.timeoutInterval = 10
        //
        //        // POST 로 보낼 정보
        ////        var params = ["snsID": "아이디3", "name": "erhersh", "mobile":"모바일", "zipcode": "12421", "address1": "wqr", "address2": "qwr"] as Dictionary
        //
        //        // httpBody 에 parameters 추가
        //        do {
        //            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        //        } catch {
        //            print("http Body Error")
        //        }
        //
        //        AF.request(request).responseString { (response) in
        //            switch response.result {
        //            case .success:
        //                print("POST 성공")
        //            case .failure(let error):
        //                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
        //            }
        //        }
        
        //        if nameTextfield.text != nil, mobileTextfield.text != nil, zipCodeTextField.text != nil, address1TextField.text != nil, address2TextField.text != nil {
        //            var params = ["name": nameTextfield.text, "mobile": mobileTextfield.text, "zipcode": zipCodeTextField.text, "address1": address1TextField.text, "address2": address2TextField.text]
        //
        //            let url = "http://192.168.0.28:3000/auth/kakao"
        //            var request = URLRequest(url: URL(string: url)!)
        //            request.httpMethod = "POST"
        //            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //            request.timeoutInterval = 10
        //
        //            // POST 로 보낼 정보
        ////            params = ["name":"아이디", "mobile":"패스워드", "zipcode": "qwr", "address1": "wqr", "address2": "qwr"] as Dictionary
        //
        //            // httpBody 에 parameters 추가
        //            do {
        //                try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        //            } catch {
        //                print("http Body Error")
        //            }
        //
        //            AF.request(request).responseString { (response) in
        //                switch response.result {
        //                case .success:
        //                    print("POST 성공")
        //                case .failure(let error):
        //                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
        //                }
        //            }
        //        } else {
        //            print("에러")
        //        }
        
        
        

}
extension AddressRegisterViewController: UITextFieldDelegate {
    
    @objc
    func keyboardWillAppear(noti: NSNotification) {
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            self.view.frame.origin.y -= keyboardHeight
        }
    }
    @objc
    func keyboardWillDisappear(noti: NSNotification) {
        if self.view.frame.origin.y != restoreFrameValue {
            if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                let keyboardHeight = keyboardRectangle.height
                self.view.frame.origin.y += keyboardHeight
            }
        }
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        //        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        self.view.frame.origin.y = self.restoreFrameValue
        return true
    }
    
}

extension AddressRegisterViewController {
    func setUI() {
        setDetails()
        setLayout()
    }
    func setDetails() {
        //        view.addSubview(mainView)
        [mainLabel, nameLabel, nameTextfield, mobileLabel, mobileTextfield, addressLabel, zipCodeTextField, addressSearchButton, address1TextField, address2TextField, registerButton].forEach {
            view.addSubview($0)
        }
        [nameLabel, mobileLabel, addressLabel].forEach {
            $0.font = $0.font.withSize(20)
            $0.textColor = .lightGray
        }
        address2TextField.delegate = self
        //        [nameTextfield, mobileTextfield, zipCodeTextField, address1TextField, address2TextField].forEach {
        //            $0.borderStyle = .none
        //            let border = CALayer()
        //            border.frame = CGRect(x: 0, y: $0.frame.size.height-1, width: $0.frame.width, height: 1)
        //            border.backgroundColor = UIColor.white.cgColor
        //            $0.layer.addSublayer(border)
        //        }
        [registerButton, addressSearchButton].forEach {
            $0.backgroundColor = .lightGray
            $0.layer.cornerRadius = 16
        }
        [nameLine, mobileLine, zipCodeLine, address1Line, address2Line].forEach {
            view.addSubview($0)
            $0.layer.borderWidth = 10
            $0.layer.backgroundColor = UIColor.lightGray.cgColor
        }
        mainLabel.numberOfLines = 4
        mainLabel.text = "세상에서 가장\n간편하고 감성적인\n사진 서비스를\n가장 먼저 경험하세요."
        //        mainLabel.font = mainLabel.font.withSize(34)
        mainLabel.font = UIFont.boldSystemFont(ofSize: 34)
        //        mainLabel.font = UIFont(name: "AppleSDGothicNeo-ExtraBold", size: 34)
        //        mainLabel.font = UIFont(name:"Apple Color Emoji" , size: 50)
        
        nameLabel.text = "이름"
        
        mobileLabel.text = "휴대폰 번호"
        mobileTextfield.keyboardType = .numberPad
        mobileTextfield.placeholder = "01000000000"
        
        addressLabel.text = "배송지"
        addressSearchButton.setTitle("주소 검색", for: .normal)
        zipCodeTextField.placeholder = "우편번호"
        address1TextField.placeholder = "기본주소"
        address2TextField.placeholder = "상세주소"
        
        registerButton.setTitle("가입하기", for: .normal)
        registerButton.backgroundColor = UIColor(red: 0.538, green: 0.462, blue: 1, alpha: 1)
        registerButton.layer.cornerRadius = 16
        registerButton.addTarget(self, action: #selector(tapRegisterButton(_:)), for: .touchUpInside)
    }
    
    func setLayout() {
        let leading = 48
        let bottom = 12
        //        mainView.snp.makeConstraints {
        //            $0.edges.equalToSuperview()
        //        }
        mainLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(4)
            $0.leading.equalToSuperview().offset(leading)
        }
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(mainLabel.snp.bottom).offset(40)
            $0.leading.equalTo(mainLabel.snp.leading)
        }
        nameTextfield.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(bottom)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-leading)
        }
        nameLine.snp.makeConstraints {
            $0.top.equalTo(nameTextfield.snp.bottom)
            $0.leading.equalTo(nameTextfield.snp.leading)
            $0.trailing.equalTo(nameTextfield.snp.trailing)
            $0.height.equalTo(1)
        }
        mobileLabel.snp.makeConstraints {
            $0.top.equalTo(nameTextfield.snp.bottom).offset(20)
            $0.leading.equalTo(nameLabel.snp.leading)
        }
        mobileTextfield.snp.makeConstraints {
            $0.top.equalTo(mobileLabel.snp.bottom).offset(bottom)
            $0.leading.equalTo(mobileLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-leading)
        }
        mobileLine.snp.makeConstraints {
            $0.top.equalTo(mobileTextfield.snp.bottom)
            $0.leading.equalTo(mobileTextfield.snp.leading)
            $0.trailing.equalTo(mobileTextfield.snp.trailing)
            $0.height.equalTo(1)
        }
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(mobileTextfield.snp.bottom).offset(20)
            $0.leading.equalTo(nameLabel.snp.leading)
        }
        zipCodeTextField.snp.makeConstraints {
            $0.top.equalTo(addressLabel.snp.bottom).offset(bottom)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalTo(addressSearchButton.snp.leading)
        }
        zipCodeLine.snp.makeConstraints {
            $0.top.equalTo(zipCodeTextField.snp.bottom).offset(4)
            $0.leading.equalTo(zipCodeTextField.snp.leading)
            $0.trailing.equalTo(zipCodeTextField.snp.trailing)
            $0.height.equalTo(1)
        }
        addressSearchButton.snp.makeConstraints {
            $0.bottom.equalTo(zipCodeTextField.snp.bottom)
            $0.trailing.equalToSuperview().inset(leading)
            $0.width.equalTo(100)
        }
        address1TextField.snp.makeConstraints {
            $0.top.equalTo(zipCodeTextField.snp.bottom).offset(20)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-leading)
        }
        address1Line.snp.makeConstraints {
            $0.top.equalTo(address1TextField.snp.bottom).offset(4)
            $0.leading.equalTo(address1TextField.snp.leading)
            $0.trailing.equalTo(address1TextField.snp.trailing)
            $0.height.equalTo(1)
        }
        address2TextField.snp.makeConstraints {
            $0.top.equalTo(address1TextField.snp.bottom).offset(20)
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-leading)
        }
        address2Line.snp.makeConstraints {
            $0.top.equalTo(address2TextField.snp.bottom).offset(4)
            $0.leading.equalTo(address2TextField.snp.leading)
            $0.trailing.equalTo(address2TextField.snp.trailing)
            $0.height.equalTo(1)
        }
        registerButton.snp.makeConstraints {
            $0.top.equalTo(address2TextField.snp.bottom).offset(60)
            $0.leading.trailing.equalToSuperview().inset(leading)
            $0.height.equalTo(55)
        }
    }
}

