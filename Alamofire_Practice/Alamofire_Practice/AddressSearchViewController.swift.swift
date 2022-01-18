////
////  AddressRegisterViewController.swift
////  PhotypetaPhotos
////
////  Created by photypeta-junha on 2021/10/22.
////  Copyright © 2021 Photy Peta. All rights reserved.
////
//
//import Alamofire
//import UIKit
//import SnapKit
//import SafariServices
//
//protocol AddressSearchResultDelegate {
//    func didSelectAddress(zipcode: String, address: String)
//}
//
//class AddressRegisterViewController: UIViewController, AddressSearchResultDelegate, AddressEditResultDelegate {
//    func didAddressChanged(isChanged: Bool) {
//        return
//    }
//    let scrollView = UIScrollView()
//    let innerView = UIView()
//    var restoreFrameValue: CGFloat = 0.0
//    var delegate: AddressEditResultDelegate?
//    let mainView = UIView()
//    let mainLabel1 = UILabel()
//    let mainLabel2 = UILabel()
//    let mainLabel3 = UILabel()
//    let mainLabel4 = UILabel()
//    let nameLabel = UILabel()
//    let nameTextfield = UITextField()
//    let mobileLabel = UILabel()
//    let mobileTextfield = UITextField()
//    let addressLabel = UILabel()
//    let zipCodeTextField = UITextField()
//    let addressSearchButton = UIButton()
//    let address1TextField = UITextField()
//    let address2TextField = UITextField()
//    let registerButton = UIButton()
//    let nameLine = UIView()
//    let mobileLine = UIView()
//    let zipCodeLine = UIView()
//    let address1Line = UIView()
//    let address2Line = UIView()
//    let checkButton = UIButton()
//    let checkTextButton = UIButton()
//    let urlLinkButton = UIButton(type: .system)
//    
//    let url = "https://mphotypeta.com/signup"
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .systemBackground
//        setUI()
//    }
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
//        self.mainView.frame.origin.y = restoreFrameValue
//        self.view.endEditing(true)
////        self.innerView.endEditing(true)
////        self.scrollView.endEditing(true)
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        //        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        //        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        //        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    func didSelectAddress(zipcode: String, address: String) {
//        self.zipCodeTextField.text = zipcode
//        self.address1TextField.text = address
//    }
//    
//    @objc
//    func tapSearchButton(_ sender: UIButton) {
//        let vc = AddressSearchViewController()
//        vc.delegate = self
//        //        self.navigationController?.pushViewController(vc, animated: true)
//        
//        self.present(vc, animated: true)
//    }
//    
//    @objc
//    func tapLinkButton(_ sender: UIButton) {
//        let linkUrl = NSURL(string: "https://photypeta.notion.site/5ed1126f475847fe82adbf86c3467082")
//        let safariView: SFSafariViewController = SFSafariViewController(url: linkUrl as! URL)
//        self.present(safariView, animated: true, completion: nil)
//    }
//    
//    @objc
//    func tapRegisterButton(_ sender: UIButton) {
//        let alert = UIAlertController(title: "모든 정보를 입력해주세요", message: nil, preferredStyle: UIAlertController.Style.alert)
//        let okAction = UIAlertAction(title: "OK", style: .cancel)
//        alert.addAction(okAction)
//        
//        let alert2 = UIAlertController(title: "개인정보 이용에 동의해주세요", message: nil, preferredStyle: UIAlertController.Style.alert)
//        let okAction2 = UIAlertAction(title: "OK", style: .cancel)
//        alert2.addAction(okAction2)
//        
//        let alert3 = UIAlertController(title: "개인정보 이용에 동의하고,\n모든 정보를 입력해주세요", message: nil, preferredStyle: UIAlertController.Style.alert)
//        let okAction3 = UIAlertAction(title: "OK", style: .cancel)
//        alert3.addAction(okAction3)
//        
//        var isFilled = true
//        
//        let name = nameTextfield.text
//        let mobile = mobileTextfield.text
//        let zipcode = zipCodeTextField.text
//        let address1 = address1TextField.text
//        let address2 = address2TextField.text
//        
//        [name, mobile, zipcode, address1, address2].forEach {
//            if $0 == nil || $0 == "" {
//                isFilled = false
//            }
//        }
//        if isFilled && checkButton.isSelected {
//            let params = ["sns_id": UserDefaults.standard.string(forKey: "snsID"), "name": name, "mobile": mobile, "postalNumber": zipcode, "defaultAddress": address1, "detailAddress": address2] as Dictionary
//        print(UserDefaults.standard.string(forKey: "snsID"), name, mobile, zipcode, address1, address2)
//            
//            var request = URLRequest(url: URL(string: url)!)
//            request.httpMethod = "POST"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            request.timeoutInterval = 10
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
//                    print(response.response?.statusCode)
//                    UserDefaults.standard.set(true, forKey: "isLoggedIn")
//                    self.presentingViewController?.presentingViewController?.dismiss(animated: true)
//                case .failure(let error):
//                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
//                }
//            }
//            //            self.navigationController?.popToRootViewController(animated: true)
//        } else if isFilled == false && checkButton.isSelected {
//            present(alert, animated: false, completion: nil)
//        } else if checkButton.isSelected == false && isFilled {
//            present(alert2, animated: false, completion: nil)
//        } else {
//            present(alert3, animated: false, completion: nil)
//        }
//    }
//    @objc
//    func tapCheckButton(_ sender: UIButton) {
//        if checkButton.isSelected {
//            checkButton.isSelected = false
//        } else {
//            checkButton.isSelected = true
//        }
//            
//    }
//   
//}
//extension AddressRegisterViewController: UITextFieldDelegate {
//    
//    @objc
//    func keyboardWillAppear(noti: NSNotification) {
//        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//            let keyboardRectangle = keyboardFrame.cgRectValue
//            let keyboardHeight = keyboardRectangle.height
//            self.view.frame.origin.y -= keyboardHeight
//        }
//    }
//    @objc
//    func keyboardWillDisappear(noti: NSNotification) {
//        if self.view.frame.origin.y != restoreFrameValue {
//            if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//                let keyboardRectangle = keyboardFrame.cgRectValue
//                let keyboardHeight = keyboardRectangle.height
//                self.view.frame.origin.y += keyboardHeight
//            }
//        }
//    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear(noti:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        //        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        textField.endEditing(true)
//        textField.resignFirstResponder()
//        return true
//    }
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear(noti:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//        self.view.frame.origin.y = self.restoreFrameValue
//        return true
//    }
//}
//
//extension AddressRegisterViewController {
//    func setUI() {
//        setDetails()
//        setLayout()
//    }
//    func setDetails() {
////        view.addSubview(scrollView)
////        scrollView.addSubview(innerView)
//        address2TextField.delegate = self
//        //        [nameTextfield, mobileTextfield, zipCodeTextField, address1TextField, address2TextField].forEach {
//        //            $0.borderStyle = .none
//        //            let border = CALayer()
//        //            border.frame = CGRect(x: 0, y: $0.frame.size.height-1, width: $0.frame.width, height: 1)
//        //            border.backgroundColor = UIColor.white.cgColor
//        //            $0.layer.addSublayer(border)
//        //        }
//        [registerButton, addressSearchButton].forEach {
//            $0.backgroundColor = .lightGray
//            $0.layer.cornerRadius = 16
//        }
//        [nameLine, mobileLine, zipCodeLine, address1Line, address2Line].forEach {
//            $0.layer.borderWidth = 10
//            $0.layer.backgroundColor = UIColor.lightGray.cgColor
//        }
////        mainLabel1.numberOfLines = 4
////        mainLabel1.text = "세상에서 가장\n간편하고 감성적인\n사진 서비스를\n가장 먼저 경험하세요."
//        //        mainLabel.font = mainLabel.font.withSize(34)
////        mainLabel.font = UIFont.boldSystemFont(ofSize: 34)
////        mainLabel1.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 34)
////        mainLabel1.textColor = .black
//        //        mainLabel.font = UIFont(name: "AppleSDGothicNeo-ExtraBold", size: 34)
//        
//        [mainLabel1, mainLabel2, mainLabel3, mainLabel4].forEach {
//            $0.font = UIFont(name: "AppleSDGothicNeo-Bold", size: 34)
//            $0.textColor = .label
//        }
//        [nameLabel, mobileLabel, addressLabel].forEach {
//            $0.font = UIFont.systemFont(ofSize: 18)
//            $0.textColor = .lightGray
//        }
//        [nameTextfield, mobileTextfield, zipCodeTextField, address1TextField, address2TextField].forEach {
//            $0.font = UIFont.systemFont(ofSize: 16)
//        }
//        mainLabel1.text = "세상에서 가장"
//        mainLabel2.text = "간편하고 감성적인"
//        mainLabel3.text = "사진 서비스를"
//        mainLabel4.text = "가장 먼저 경험하세요."
//        
//        nameLabel.text = "이름"
//        
//        mobileLabel.text = "휴대폰 번호"
//        mobileTextfield.keyboardType = .numberPad
//        mobileTextfield.placeholder = "01000000000"
//        
//        addressLabel.text = "배송지"
//        addressSearchButton.setTitle("주소 검색", for: .normal)
//        addressSearchButton.addTarget(self, action: #selector(tapSearchButton(_:)), for: .touchUpInside)
//        zipCodeTextField.placeholder = "우편번호"
//        zipCodeTextField.isEnabled = false
//        address1TextField.placeholder = "기본주소"
//        address1TextField.isEnabled = false
//        address2TextField.placeholder = "상세주소"
//        
//        registerButton.setTitle("가입하기", for: .normal)
//        registerButton.backgroundColor = UIColor(red: 0.538, green: 0.462, blue: 1, alpha: 1)
//        registerButton.layer.cornerRadius = 16
//        registerButton.addTarget(self, action: #selector(tapRegisterButton(_:)), for: .touchUpInside)
//        
//        checkButton.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
//        checkButton.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .selected)
//        checkTextButton.setTitle("[필수]개인정보 수집 이용 동의", for: .normal)
//        checkTextButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
//        checkButton.tintColor = UIColor.lightGray
//        checkTextButton.setTitleColor(UIColor.lightGray, for: .normal)
//        [checkButton, checkTextButton].forEach {
//            $0.addTarget(self, action: #selector(tapCheckButton(_:)), for: .touchUpInside)
//        }
//        
//        urlLinkButton.setTitle("보기", for: .normal)
//        urlLinkButton.setTitleColor(UIColor.lightGray, for: .normal)
//        urlLinkButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//        urlLinkButton.addTarget(self, action: #selector(tapLinkButton(_:)), for: .touchUpInside)
//    }
//    
//    func setLayout() {
//        let leading = 48
//        let bottom = 8
//        let mainLabelOffset = -4
//        let nameLabelTop = 8
//        let textFieldTop = 10
//        //        mainView.snp.makeConstraints {
//        //            $0.edges.equalToSuperview()
//        //        }
////        scrollView.snp.makeConstraints {
////            $0.edges.equalToSuperview()
////        }
////        innerView.snp.makeConstraints {
////            $0.width.equalTo(scrollView.frameLayoutGuide)
////            $0.edges.equalTo(scrollView.contentLayoutGuide)
////        }
//        [mainLabel1, mainLabel2, mainLabel3, mainLabel4, nameLabel, nameTextfield, mobileLabel, mobileTextfield, addressLabel, zipCodeTextField, addressSearchButton, address1TextField, address2TextField, registerButton,nameLine, mobileLine, zipCodeLine, address1Line, address2Line,  checkButton, checkTextButton, urlLinkButton].forEach {
//            view.addSubview($0)
//        }
//        mainLabel1.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(8)
//            $0.leading.equalToSuperview().offset(leading)
//        }
//        mainLabel2.snp.makeConstraints {
//            $0.top.equalTo(mainLabel1.snp.bottom).offset(mainLabelOffset)
//            $0.leading.equalTo(mainLabel1)
//        }
//        mainLabel3.snp.makeConstraints {
//            $0.top.equalTo(mainLabel2.snp.bottom).offset(mainLabelOffset)
//            $0.leading.equalTo(mainLabel1)
//        }
//        mainLabel4.snp.makeConstraints {
//            $0.top.equalTo(mainLabel3.snp.bottom).offset(mainLabelOffset)
//            $0.leading.equalTo(mainLabel1)
//        }
//        nameLabel.snp.makeConstraints {
//            $0.top.equalTo(mainLabel4.snp.bottom).offset(nameLabelTop)
//            $0.leading.equalTo(mainLabel1.snp.leading)
//        }
//        nameTextfield.snp.makeConstraints {
//            $0.top.equalTo(nameLabel.snp.bottom).offset(bottom)
//            $0.leading.equalTo(nameLabel.snp.leading)
//            $0.trailing.equalToSuperview().offset(-leading)
//        }
//        nameLine.snp.makeConstraints {
//            $0.top.equalTo(nameTextfield.snp.bottom)
//            $0.leading.equalTo(nameTextfield.snp.leading)
//            $0.trailing.equalTo(nameTextfield.snp.trailing)
//            $0.height.equalTo(1)
//        }
//        mobileLabel.snp.makeConstraints {
//            $0.top.equalTo(nameTextfield.snp.bottom).offset(20)
//            $0.leading.equalTo(nameLabel.snp.leading)
//        }
//        mobileTextfield.snp.makeConstraints {
//            $0.top.equalTo(mobileLabel.snp.bottom).offset(textFieldTop)
//            $0.leading.equalTo(mobileLabel.snp.leading)
//            $0.trailing.equalToSuperview().offset(-leading)
//        }
//        mobileLine.snp.makeConstraints {
//            $0.top.equalTo(mobileTextfield.snp.bottom)
//            $0.leading.equalTo(mobileTextfield.snp.leading)
//            $0.trailing.equalTo(mobileTextfield.snp.trailing)
//            $0.height.equalTo(1)
//        }
//        addressLabel.snp.makeConstraints {
//            $0.top.equalTo(mobileTextfield.snp.bottom).offset(20)
//            $0.leading.equalTo(nameLabel.snp.leading)
//        }
//        zipCodeTextField.snp.makeConstraints {
//            $0.top.equalTo(addressLabel.snp.bottom).offset(textFieldTop)
//            $0.leading.equalTo(nameLabel.snp.leading)
//            $0.trailing.equalTo(addressSearchButton.snp.leading)
//        }
//        zipCodeLine.snp.makeConstraints {
//            $0.top.equalTo(zipCodeTextField.snp.bottom).offset(4)
//            $0.leading.equalTo(zipCodeTextField.snp.leading)
//            $0.trailing.equalTo(zipCodeTextField.snp.trailing)
//            $0.height.equalTo(1)
//        }
//        addressSearchButton.snp.makeConstraints {
//            $0.bottom.equalTo(zipCodeTextField.snp.bottom)
//            $0.trailing.equalToSuperview().inset(leading)
//            $0.width.equalTo(100)
//        }
//        address1TextField.snp.makeConstraints {
//            $0.top.equalTo(zipCodeTextField.snp.bottom).offset(textFieldTop)
//            $0.leading.equalTo(nameLabel.snp.leading)
//            $0.trailing.equalToSuperview().offset(-leading)
//        }
//        address1Line.snp.makeConstraints {
//            $0.top.equalTo(address1TextField.snp.bottom).offset(4)
//            $0.leading.equalTo(address1TextField.snp.leading)
//            $0.trailing.equalTo(address1TextField.snp.trailing)
//            $0.height.equalTo(1)
//        }
//        address2TextField.snp.makeConstraints {
//            $0.top.equalTo(address1TextField.snp.bottom).offset(textFieldTop)
//            $0.leading.equalTo(nameLabel.snp.leading)
//            $0.trailing.equalToSuperview().offset(-leading)
//        }
//        address2Line.snp.makeConstraints {
//            $0.top.equalTo(address2TextField.snp.bottom).offset(4)
//            $0.leading.equalTo(address2TextField.snp.leading)
//            $0.trailing.equalTo(address2TextField.snp.trailing)
//            $0.height.equalTo(1)
//        }
//        checkButton.snp.makeConstraints {
//            $0.top.equalTo(address2Line.snp.bottom).offset(16)
//            $0.leading.equalTo(address2Line.snp.leading)
//        }
//        checkTextButton.snp.makeConstraints {
//            $0.centerY.equalTo(checkButton.snp.centerY)
//            $0.leading.equalTo(checkButton.snp.trailing).offset(4)
//        }
//        urlLinkButton.snp.makeConstraints {
//            $0.centerY.equalTo(checkTextButton.snp.centerY)
//            $0.leading.equalTo(checkTextButton.snp.trailing).offset(12)
//        }
//        registerButton.snp.makeConstraints {
//            $0.top.equalTo(address2TextField.snp.bottom).offset(60)
//            $0.leading.trailing.equalToSuperview().inset(leading)
////            $0.bottom.trailing.equalToSuperview().inset(leading)
//            $0.height.equalTo(55)
//        }
//    }
//}
//
