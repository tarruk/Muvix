//
//  AppDelegate.swift
//  MoviesApp
//
//  Created by Tarek on 12/03/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setInit()
        return true
    }
    
    func setInit() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = BaseNavigationController(rootViewController: HomeViewController())
        window?.makeKeyAndVisible()
    }

  

}

