//
//  SnsSignInViewComtroller.swift
//  Alamofire_Practice
//
//  Created by photypeta-junha on 2021/11/18.
//


import UIKit
import AuthenticationServices
import SnapKit

class SnsSignInViewComtroller: UIViewController {
    
    let appleBUtton = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}

extension SnsSignInViewComtroller {
    @objc func tapAppleSignInButton(_ sender: ASAuthorizationAppleIDButton) {
            let request = ASAuthorizationAppleIDProvider().createRequest()
            request.requestedScopes = [.fullName, .email]
            let controller = ASAuthorizationController(authorizationRequests: [request])
            controller.delegate = self as? ASAuthorizationControllerDelegate
            controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
            controller.performRequests()
        }
}

extension SnsSignInViewComtroller {
    func setUI() {
        setDetails()
        setLayout()
    }
    func setDetails() {
        appleBUtton.addTarget(self, action: #selector(tapAppleSignInButton(_:)), for: .touchUpInside)
    }
    func setLayout() {
        [appleBUtton].forEach {
            view.addSubview($0)
        }
        appleBUtton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(20)
        }
    }
}



extension SnsSignInViewComtroller: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    //Apple 로그인을 modal로 present
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("apple Login Error")
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            //계정 정보
            let userIdentifierCode = appleIDCredential.authorizationCode
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            print("userIdentifierCode", userIdentifierCode ?? "", "fullName", fullName ?? "", "email", email ?? "")
            if let authorizationCode = appleIDCredential.authorizationCode,
               let userIdentifierCodeString = String(data: userIdentifierCode!, encoding: .utf8),
               let identityToken = appleIDCredential.identityToken,
               let authString = String(data: authorizationCode, encoding: .utf8),
               let tokenString = String(data: identityToken, encoding: .utf8) {
                print("appleIdentifier")
                print("authorizationCode", authorizationCode, "\nidentityToken", identityToken, "\nauthString", authString, "\ntokenString", tokenString)
            }
            
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            print("password")
            print(username, password)
        default:
            break
        }
        
    }
}
