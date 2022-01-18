//
//  EditDetailViewController.swift
//  Alamofire_Practice
//
//  Created by photypeta-junha on 2022/01/18.
//

import UIKit
import SnapKit
import Alamofire
import SwiftUI

class EditDetailViewController: UIViewController {
    
    let label = UILabel()
    let textField = UITextField()
    var Key: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        view.backgroundColor = .systemBackground
        setBackButton()
        setOKButton()
        textField.text = ""
    }
}

extension EditDetailViewController {
    @objc
    func tapBackButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc
    func tapOKButton(_ sender: UIButton) {
        if textField.text == "" {
            let alertView = UIAlertController(title: "수정하실 내용을 입력해주세요", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        } else {
            //MARK: - 이미지 전송 Alert
            let alertView = UIAlertController(title: "변경 완료", message: "성공적으로 변경되었습니다.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .cancel) { _ in
                self.dismiss(animated: true, completion: nil)
            }
            alertView.addAction(okAction)
            
            //        let id = UserDefaults.standard.string(forKey: "snsID")!
            let url = "https://ptsv2.com/t/q2a7o-1642038120/post"
            //        let header: HTTPHeaders = ["snsId": id, "Content-Type": "application/json"]
            let param = [Key: textField.text!]
            var request = URLRequest(url: URL(string: url)!)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("gawrgarwgarew", forHTTPHeaderField: "snsId")
            request.timeoutInterval = 10
            do {
                try request.httpBody = JSONSerialization.data(withJSONObject: param, options: [])
            } catch {
                print("http Body Error")
            }
            AF.request(request).responseString { (response) in
                switch response.result {
                case .success:
                    print("POST 성공")
                    print(response.response?.statusCode)
                    self.present(alertView, animated: true, completion: nil)
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
        }
    }
    func setBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        backButton.addTarget(self, action: #selector(tapBackButton(_:)), for: .touchUpInside)
        backButton.tintColor = .label
        let barButton = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = barButton
    }
    func setOKButton() {
        let okButton = UIButton(type: .custom)
        okButton.setTitle("확인", for: .normal)
        okButton.setTitleColor(.label, for: .normal)
        okButton.addTarget(self, action: #selector(tapOKButton(_:)), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: okButton)
        self.navigationItem.rightBarButtonItem = barButton
    }
}

extension EditDetailViewController {
    func setUI() {
        setDetails()
        setLayout()
    }
    func setDetails() {
        
    }
    func setLayout() {
        [label, textField].forEach {
            view.addSubview($0)
        }
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            $0.leading.equalToSuperview().inset(40)
            $0.width.equalTo(100)
        }
        textField.snp.makeConstraints {
            $0.top.equalTo(label.snp.bottom).offset(20)
            $0.leading.equalTo(label)
            $0.trailing.equalToSuperview().inset(40)
        }
    }
}
