//
//  LaunchesViewType.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Foundation

enum LaunchesViewType {
    case items(launch: LaunchViewAdapter)
    case empty
    case error(message: String)
}
