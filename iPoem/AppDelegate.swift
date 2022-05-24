//
//  AppDelegate.swift
//  iPoem
//
//  Created by zhengqiang zhang on 2022/5/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let window = UIWindow()
        window.rootViewController = IPMainViewController()
        window.backgroundColor = .white
        self.window = window
        window.makeKeyAndVisible()
        
        return true
    }

  


}

