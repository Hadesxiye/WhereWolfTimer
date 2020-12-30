//
//  AppDelegate.swift
//  WhereWolfTimer
//
//  Created by 王浩祯 on 2020/12/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.makeKeyAndVisible()
        let nav = UINavigationController(rootViewController: MainViewController())
        window?.rootViewController = nav
        return true
    }


}

