//
//  Rocket.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Foundation

struct Rocket: Codable {
    let flickrImages: [String]?
    let name: String?
    let type: String?
    let active: Bool?
    let country: String?
    let company: String?
    let wikipedia: String?
    let description: String?
    let id: String?

    private enum CodingKeys: String, CodingKey {
        case flickrImages = "flickr_images"
        case name = "name"
        case type = "type"
        case active = "active"
        case country = "country"
        case company = "company"
        case wikipedia = "wikipedia"
        case description = "description"
        case id = "id"
    }

}

