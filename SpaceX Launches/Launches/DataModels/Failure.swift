//
//  Failure.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Foundation

struct Failure: Codable {
    let time: Int?
    let altitude: Int?
    let reason: String?
}
