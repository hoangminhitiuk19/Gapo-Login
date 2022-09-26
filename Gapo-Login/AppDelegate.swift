//
//  AppDelegate.swift
//  Gapo-Login
//
//  Created by Dung on 14/9/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let userLoginStatus = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        var view = UIViewController()
        if (userLoginStatus == false) || (userLoginStatus == true && checkLogInState() == false)  {
            view = MyViewController()
        } else {
            view = NotificationViewController()
        }
        pushScreen(view: view)
        return true
    }
    
    func pushScreen(view: UIViewController) {
        let navigation = UINavigationController(rootViewController: view)
        window = UIWindow( frame: UIScreen.main.bounds)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        navigation.navigationBar.prefersLargeTitles = true
    }
    
    func checkLogInState() -> Bool {
        let loggedInTime = UserDefaults.standard.integer(forKey: "logInTime")
        let expireTime = 300000
        let currentTime = Date.currentTimeStamp
        
        if (currentTime - loggedInTime ) > expireTime {
                return false
            } else {
                return true
        }
    }
}

