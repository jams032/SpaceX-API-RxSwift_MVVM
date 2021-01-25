//
//  LaunchDetailViewModel.swift
//  SpaceX_API
//
//  Created by Jamshed on 23/1/21.
//  Copyright © 2021 Jamshed. All rights reserved.
//

import RxSwift
import RxCocoa

class LaunchDetailViewModel {
    private let launchURLString = "https://api.spacexdata.com/v4/launches/" // flight number
    private let rocketURLString = "https://api.spacexdata.com/v4/rockets/" // rocket id , works https://api.spacexdata.com/v4/rockets/5e9d0d95eda69973a809d1ec
    private let decoder = JSONDecoder()

    var launch: PublishSubject<LaunchModel> = PublishSubject()
    var rocket: PublishSubject<RocketModel> = PublishSubject()
    var currentLaunch : LaunchModel!
    var currentRocket : RocketModel!

    init(flightNumber: Int, rocketId: String, launch:LaunchModel) {
        //flightNumber: Int, rocketId: String,
        currentLaunch = launch
        self.retrieveLaunchDetails() // with: launch.flightNumber!
        self.retrieveRocketDetails(with: launch.rocket ?? "")
    }

    func retrieveLaunchDetails() { // with flightNumber: Int
        
       self.launch.onNext(currentLaunch)
        return
        
        // we don't have access to https://api.spacexdata.com/v4/launches/117(flightNumber) , so we sent the list #imageLiteral(resourceName: "Screenshot 2021-01-22 at 12.40.26 PM.png")
        guard let url = URL(string: "\(launchURLString)\("flightNumber")") else { return }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                let launch = try self.decoder.decode(LaunchModel.self, from: data)
                self.launch.onNext(launch)
            } catch let error {
               print("Error:", error.localizedDescription)
            }
        }.resume()
    }

    func retrieveRocketDetails(with rocketId: String) {
        guard let url = URL(string: "\(rocketURLString)\(rocketId)") else { return }
        print("url:\(url)")
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                                  print(json)
                               }
                
                let rocket = try self.decoder.decode(RocketModel.self, from: data)
                self.currentRocket = rocket

                self.rocket.onNext(rocket)
            } catch let error {
               print("Error:", error.localizedDescription)
            }
        }.resume()
    }
}
