//
//  Launch.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Foundation

struct Launch: Codable {
    let links: Links?
    let rocket: String?
    let success: Bool?
    let details: String?
    let flightNumber: Int?
    let name: String?
    let dateUtc: String?
    let upcoming: Bool?
    let id: String?
    var launchDate: Date {
        guard let dateUtc = dateUtc else { return Date() }
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return df.date(from: dateUtc) ?? Date()
    }

    private enum CodingKeys: String, CodingKey {
        case links = "links"
        case rocket = "rocket"
        case success = "success"
        case details = "details"
        case flightNumber = "flight_number"
        case name = "name"
        case dateUtc = "date_utc"
        case upcoming = "upcoming"
        case id = "id"
    }

}
