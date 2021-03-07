//
//  RocketMapperProtocol.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Foundation

protocol RocketMapperProtocol {
    /// Maps Rocket entity into displayable view adapter
    /// - Parameter launch: Rocket Entity
    func mapToViewAdapter(_ rocket: Rocket) -> RocketViewAdapter
}
