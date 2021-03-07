//
//  Fairings.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Foundation

struct Fairings: Codable {
    let reused: Bool?
    let recoveryAttempt: Bool?
    let recovered: Bool?
    let ships: [String]?
}
