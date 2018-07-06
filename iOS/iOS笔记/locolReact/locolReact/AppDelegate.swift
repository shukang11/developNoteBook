//
//  AppDelegate.swift
//  locolReact
//
//  Created by tree on 2018/5/21.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow.init()
        SXRRouteFileCache.shared.cleanCache()
        let us = "http"
        let controller = SXRViewController.init(uri: URL.init(string: "\(us)")!, remoteURL: URL.init(string: "http://127.0.0.1:5000/t/index.html"))
        let navigation = UINavigationController.init(rootViewController: controller)
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
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

