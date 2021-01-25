//
//  RocketModel.swift
//  SpaceX_API
//
//  Created by Jamshed on 23/1/21.
//  Copyright © 2021 Jamshed. All rights reserved.
//

import Foundation

struct RocketModel: Decodable {
    let id: String
    let active: Bool
    let stages: Int
    let boosters: Int
    let country: String
    let company: String
    let wikipedia: String
    let description: String
    let rocketName: String

    enum CodingKeys: String, CodingKey {
        case id
        case active
        case stages
        case boosters
        case country
        case company
        case wikipedia
        case description
        case rocketName = "name"
    }
}
