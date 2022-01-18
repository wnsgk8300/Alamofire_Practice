//
//  AppDelegate.swift
//  Alamofire_Practice
//
//  Created by JEON JUNHA on 2021/09/05.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
//        window!.rootViewController = ViewController()
//        window!.rootViewController = SnsSignInViewComtroller()
//        window!.rootViewController = AddressRegisterViewController()EditProfileViewController
        window!.rootViewController = EditViewController()
        window!.makeKeyAndVisible()
        
        return true
    }
}

