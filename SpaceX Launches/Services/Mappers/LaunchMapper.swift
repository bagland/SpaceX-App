//
//  LaunchMapper.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Foundation

class LaunchMapper: LaunchMapperProtocol {
    func mapToViewAdapter(_ launch: Launch) -> LaunchViewAdapter {
        let df = DateFormatter()
        df.dateFormat = "MMM.dd yyyy"
        return .init(
            launchNumber: "Launch: #\(String(launch.flightNumber ?? 0))",
            name: launch.name ?? "",
            descr: launch.details,
            date: df.string(from: launch.launchDate),
            isUpcoming: launch.upcoming ?? true,
            imgUrl: launch.links?.patch?.small,
            rocket: launch.rocket ?? "")
    }
}
