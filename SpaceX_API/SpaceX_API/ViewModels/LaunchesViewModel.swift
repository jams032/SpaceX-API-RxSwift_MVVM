//
//  LaunchesViewModel.swift
//  SpaceX_API
//
//  Created by Jamshed on 23/1/21.
//  Copyright © 2021 Jamshed. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

enum LaunchSortingOrder: Int {
    case latest, earliest, alphabetically, alphabeticallyReversed
}

enum LaunchFilter: Int {
    case all, successOnly
}

class LaunchesViewModel {

    private var originalLaunches: [LaunchModel] = []
    private var currentLaunches: [LaunchModel] = []
    let sections: PublishSubject<[SectionModel<String, LaunchModel>]> = PublishSubject()

    private var launchSortingOrder: LaunchSortingOrder = .latest

    func retrieveLaunches() {
        guard let url = URL(string: launchesURLString) else { return }
        print("url:\(url)")
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else { return }
            do {
                
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                      print(json)
                   }
                
                let decoder = JSONDecoder()
                var launches = try decoder.decode([LaunchModel].self, from: data)
                
                // Sort last 3 years data
                let filtered = launches.filter{ ($0.launchDate.contains("2021") || $0.launchDate.contains("2020") || $0.launchDate.contains("2019")) }
               launches = filtered
                
//                var ids : [String] = []
//                for launc in launches {
//                    if !ids.contains(launc.rocket!) {
//                        ids.append(launc.rocket!)
//                    }
//                }
//                print(ids.description)
                self.originalLaunches = launches
                self.currentLaunches = launches
                self.sort(by: self.launchSortingOrder)
                self.updateSections()
            } catch let error {
               print("Error:", error.localizedDescription)
            }
        }.resume()
    }

    private func updateSections(byFirstCharacter: Bool = false, ascending: Bool = false) {
        var sectionModels: [SectionModel<String, LaunchModel>] = []
    //    let groupedArray = Dictionary(grouping: currentLaunches, by: { byFirstCharacter ? $0.missionNameFirstCharacter : $0.launchYear })
        let groupedArray = Dictionary(grouping: currentLaunches, by: { byFirstCharacter ? $0.missionNameFirstCharacter : $0.dateUTC })

        var sortedLaunches: [(key: String, value: [LaunchModel])]
        if ascending {
            sortedLaunches = groupedArray.sorted { $0.key < $1.key }
        } else {
            sortedLaunches = groupedArray.sorted { $0.key > $1.key }
        }

        sortedLaunches.forEach({ launch in
            sectionModels.append(SectionModel(model: launch.key, items: launch.value))
        })

        sections.onNext(sectionModels)
    }

    // MARK: - Sort Launches

    func sort(by launchSortingOrder: LaunchSortingOrder?) {
        guard let launchSortingOrder = launchSortingOrder else { return }
        self.launchSortingOrder = launchSortingOrder

        switch launchSortingOrder {
        case .latest: sort(latestFirst: true)
        case .earliest: sort(latestFirst: false)
        case .alphabetically: sort(alphabetically: true)
        case .alphabeticallyReversed: sort(alphabetically: false)
        }
    }

    private func sort(latestFirst: Bool) {
        if latestFirst {
            currentLaunches = currentLaunches.sorted { $0.launchDate > $1.launchDate } // launchDate
        } else {
            currentLaunches = currentLaunches.sorted { $0.launchDate < $1.launchDate } // launchDate
        }
        updateSections(ascending: latestFirst == false)
    }

    private func sort(alphabetically: Bool) {
        if alphabetically {
            currentLaunches = currentLaunches.sorted { $0.name < $1.name } //missionName
        } else {
            currentLaunches = currentLaunches.sorted { $0.name > $1.name } //missionName
        }
        updateSections(byFirstCharacter: true, ascending: alphabetically)
    }

    // MARK: - Filter Launches

    func filter(by launchFilter: LaunchFilter?) {
        if launchFilter == .all {
            currentLaunches = originalLaunches
        } else {
            currentLaunches = originalLaunches.filter { $0.success == true } // launchSuccess
        }

        switch launchSortingOrder {
        case .latest:
            sort(latestFirst: true)
            updateSections(ascending: false)
        case .earliest:
            sort(latestFirst: false)
            updateSections(ascending: true)
        case .alphabetically:
            sort(alphabetically: true)
            updateSections(byFirstCharacter: true, ascending: true)
        case .alphabeticallyReversed:
            sort(alphabetically: false)
            updateSections(byFirstCharacter: true, ascending: false)
        }
    }
}
