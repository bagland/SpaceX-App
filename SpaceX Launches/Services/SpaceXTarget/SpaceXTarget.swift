//
//  SpaceXTarget.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Moya

enum SpaceXTarget: TargetType {
    case launches
    case rocket(id: String)
    
    var baseURL: URL {
        return URL(string: "https://api.spacexdata.com/v4")!
    }
    
    var path: String {
        switch self {
        case .launches:
            return "launches"
        case .rocket(let id):
            return "rockets/\(id)"
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var method: Method {
        switch self {
        default: return .get
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
