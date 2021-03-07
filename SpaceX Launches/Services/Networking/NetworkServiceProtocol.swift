//
//  NetworkServiceProtocol.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Moya
import RxSwift

protocol NetworkServiceProtocol {
    /// - Returns: Rx Single of launch models..
    func getLaunches() -> Single<[Launch]>
    /// - Returns: Rx Single of a rocket model.
    func getRocket(id: String) -> Single<Rocket>
}
