//
//  Launch.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Foundation

struct Launch: Codable {
    let fairings: Fairings?
    let links: Links?
    let tbd: Bool?
    let net: Bool?
    let window: Int?
    let rocket: String?
    let success: Bool?
    let details: String?
    let crew: [String]?
    let ships: [String]?
    let capsules: [String]?
    let payloads: [String]?
    let launchpad: String?
    let launchLibraryId: String?
    let failures: [Failure]?
    let flightNumber: Int?
    let name: String?
    let dateUtc: String?
    let upcoming: Bool?
    let cores: [Core]?
    let id: String?
    var launchDate: Date {
        guard let dateUtc = dateUtc else { return Date() }
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return df.date(from: dateUtc) ?? Date()
    }

    private enum CodingKeys: String, CodingKey {

        case fairings = "fairings"
        case links = "links"
        case tbd = "tbd"
        case net = "net"
        case window = "window"
        case rocket = "rocket"
        case success = "success"
        case details = "details"
        case crew = "crew"
        case ships = "ships"
        case capsules = "capsules"
        case payloads = "payloads"
        case launchpad = "launchpad"
        case launchLibraryId = "launch_library_id"
        case failures = "failures"
        case flightNumber = "flight_number"
        case name = "name"
        case dateUtc = "date_utc"
        case upcoming = "upcoming"
        case cores = "cores"
        case id = "id"
    }

}
