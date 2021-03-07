//
//  NetworkService.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Moya
import RxSwift

class NetworkService: NetworkServiceProtocol {
    private let provider = MoyaProvider<SpaceXTarget>(plugins: [NetworkLoggerPlugin()])
    
    func getLaunches() -> Single<[Launch]> {
        provider
            .rx
            .request(.launches)
            .map([Launch].self)
    }
    
    func getRocket(id: String) -> Single<Rocket> {
        provider
            .rx
            .request(.rocket(id: id))
            .map(Rocket.self)
    }
}
