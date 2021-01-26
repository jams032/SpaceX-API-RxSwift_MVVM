//
//  LaunchesCoordinatorViewController.swift
//  SpaceX_API
//
//  Created by Jamshed on 23/1/21.
//  Copyright © 2021 Jamshed. All rights reserved.
//
import UIKit

class LaunchesCoordinator: Coordinator {
    private lazy var launchDetailCoordinator = LaunchDetailCoordinator(navigationController: navigationController)

    func start() {
        guard let launchesViewController = LaunchesViewController.instatiate() as? LaunchesViewController else { return }
        launchesViewController.viewModel = LaunchesViewModel()
        launchesViewController.delegate = self
        navigationController?.pushViewController(launchesViewController, animated: false)
    }
}

extension LaunchesCoordinator: LaunchesNavigationDelegate {
    func navigateToLaunchDetails(missionName: String,id: String, flightNumber: Int, rocketId: String,launch:LaunchModel) {
        launchDetailCoordinator.start(with: missionName,id: id, flightNumber: flightNumber, rocketId: rocketId,launch: launch)
    }
}
