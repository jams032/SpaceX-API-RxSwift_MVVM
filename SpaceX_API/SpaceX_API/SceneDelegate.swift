//
//  SceneDelegate.swift
//  SpaceX_API
//
//  Created by Admin on 22/1/21.
//  Copyright © 2021 Jamshed. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private var launchesCoordinator: LaunchesCoordinator!

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        launchesCoordinator = LaunchesCoordinator(navigationController: navigationController)
        launchesCoordinator.start()
        window?.makeKeyAndVisible()

        UINavigationBar.appearance().prefersLargeTitles = true

        guard let _ = (scene as? UIWindowScene) else { return }
        
    }


}

