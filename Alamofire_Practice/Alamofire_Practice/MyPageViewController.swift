//
//  MyPageViewController.swift
//  Alamofire_Practice
//
//  Created by photypeta-junha on 2022/01/17.
//

import UIKit
import Alamofire
import SnapKit

class MyPageViewController: UIViewController {
    
    var nameLabel = UILabel()
    let editProfileButton = UIButton()
    let infoView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        view.backgroundColor = .red
    }
}

extension MyPageViewController {
    func setUI() {
        setDetails()
        setLayout()
    }
    func setDetails() {
        infoView.backgroundColor = .gray
    }
    func setLayout() {
        [infoView].forEach {
            view.addSubview($0)
        }
        [nameLabel, editProfileButton].forEach {
            infoView.addSubview($0)
        }
        infoView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
    }
}
