//
//  AppDelegate.swift
//  TennisAnalysis
//
//  Created by 市田圭司 on 2021/11/25.
//

import UIKit
import NCMB

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //NCMBと同期付け
        NCMB.setApplicationKey("028d5c86ef9b75e4852d0545572f8bbe69c275fe3f677c4d1f6fd62bdb428667", clientKey: "a48d1980c7bd7a5656a4ad28d8036cacfdc3db37edd63394137a36be6ef4b89d")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}





