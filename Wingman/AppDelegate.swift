//
//  AppDelegate.swift
//  Wingman
//
//  Created by Kraisorn Soisakhu on 5/16/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.initApp()
        
        return true
    }
}

extension AppDelegate {
    func initApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        window?.rootViewController = WMAppManager.shared.storeView()
        window?.makeKeyAndVisible()
    }
}
