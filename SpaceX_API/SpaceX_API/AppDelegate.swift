//
//  AppDelegate.swift
//  SpaceX_API
//
//  Created by Jamshed on 23/1/21.
//  Copyright © 2021 Jamshed. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    private var launchesCoordinator: LaunchesCoordinator!
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        launchesCoordinator = LaunchesCoordinator(navigationController: navigationController)
        launchesCoordinator.start()
        window?.makeKeyAndVisible()
        
        return true
    }

}

