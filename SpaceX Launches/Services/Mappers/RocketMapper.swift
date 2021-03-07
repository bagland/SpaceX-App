//
//  RocketMapper.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Foundation

class RocketMapper: RocketMapperProtocol {
    func mapToViewAdapter(_ rocket: Rocket) -> RocketViewAdapter {
        .init(
            name: rocket.name ?? "",
            descr: rocket.description,
            imgUrl: rocket.flickrImages?.first)
    }
}
