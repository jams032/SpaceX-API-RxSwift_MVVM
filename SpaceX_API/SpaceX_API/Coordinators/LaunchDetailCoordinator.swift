//
//  LaunchDetailCoordinator.swift
//  SpaceX_API
//
//  Created by Jamshed on 23/1/21.
//  Copyright © 2021 Jamshed. All rights reserved.
//

import SafariServices

class LaunchDetailCoordinator: Coordinator {
    func start(with missionName: String, flightNumber: Int, rocketId: String,launch:LaunchModel) {
        guard let launchDetailViewController = LaunchDetailViewController.instatiate() as? LaunchDetailViewController else { return }
        launchDetailViewController.title = missionName
        launchDetailViewController.viewModel = LaunchDetailViewModel(flightNumber: flightNumber, rocketId: rocketId,launch: launch)
        launchDetailViewController.delegate = self
        navigationController?.pushViewController(launchDetailViewController, animated: true)
    }
}

extension LaunchDetailCoordinator: LaunchDetailNavigationDelegate {
    func presentRocketInformation(url: URL) {
        navigationController?.present(SFSafariViewController(url: url), animated: true)
    }
}
