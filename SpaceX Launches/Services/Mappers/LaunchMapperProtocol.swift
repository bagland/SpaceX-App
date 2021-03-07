//
//  LaunchMapperProtocol.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Foundation

protocol LaunchMapperProtocol {
    /// Maps network launch entity into displayable view adapter
    /// - Parameter launch: Launch Event Entity
    func mapToViewAdapter(_ launch: Launch) -> LaunchViewAdapter
}
