//
//  SceneDelegate.swift
//  Gapo-Login
//
//  Created by Dung on 14/9/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: MyViewController())
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        print("didDisconnect at \(String(describing: getTime))")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print("DidBecomeActive at \(String(describing: getTime))")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        print("WillResignActive at \(String(describing: getTime))")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        print("WillEnterForeground at \(String(describing: getTime))")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        print("DidEnterBackground at \(String(describing: getTime))")
    }

    func getTime() -> String{
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let second = calendar.component(.second, from: date)
        let result = "\(hour):\(minutes):\(second)"
        return result
        
    }
        
}

