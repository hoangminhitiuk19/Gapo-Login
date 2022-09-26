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
        window = UIWindow(frame: UIScreen.main.bounds)
        let userLoginStatus = UserDefaults.standard.bool(forKey: "isUserLoggedIn")
        if (userLoginStatus == false) || (userLoginStatus == true && checkLogInState() == false)  {
            let controller = MyViewController()
            setupWindow(root: controller)
        } else {
            showHomeScreen()
        }
        
        return true
    }
    //----------------------------------------
    func setupWindow(root: UIViewController) {
        window?.rootViewController = root
        window?.makeKeyAndVisible()
    }
    //----------------------------------------
    func showHomeScreen() {
        let tableController = NotificationViewController()
        let tableNavigation = UINavigationController(rootViewController: tableController)
        tableNavigation.navigationBar.prefersLargeTitles = true
        
        let collectionController = NotificationCollectionController()
        let collectionNavigation = UINavigationController(rootViewController: collectionController)
        collectionNavigation.navigationBar.prefersLargeTitles = true
        
        let tabbarVC = UITabBarController()
        tabbarVC.viewControllers = [tableNavigation, collectionNavigation]
        setupWindow(root: tabbarVC)
    }
    //----------------------------------------
    func userDidLogin() {
        showHomeScreen()
    }
    //----------------------------------------
    func checkLogInState() -> Bool {
        let loggedInTime = UserDefaults.standard.integer(forKey: "logInTime")
        let expireTime = 3000000
        let currentTime = Date.currentTimeStamp
        
        if (currentTime - loggedInTime ) > expireTime {
                return false
            } else {
                return true
        }
    }
}

