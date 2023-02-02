//
//  AppDelegate.swift
//  PinOnMobile-lib
//
//  Created by x-oauth-basic on 02/02/2023.
//  Copyright (c) 2023 x-oauth-basic. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigationController: UINavigationController?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let window = window {
            let mainVC = ViewController()
            navigationController = UINavigationController(rootViewController: mainVC)
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
     }

    func applicationWillEnterForeground(_ application: UIApplication) {
       }

    func applicationDidBecomeActive(_ application: UIApplication) {
       }

    func applicationWillTerminate(_ application: UIApplication) {
       }


}

