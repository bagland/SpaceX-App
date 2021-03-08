//
//  MockNetworking.swift
//  SpaceX LaunchesTests
//
//  Created by Baglan Daribayev on 3/8/21.
//

import Foundation
import RxSwift
@testable import SpaceX_Launches

enum MockError: Error, LocalizedError {
    case badRequest
    var errorDescription: String? {
        return "Bad request"
    }
}

class MockNetworking: NetworkServiceProtocol {
    convenience init(launches: [Launch]? = nil,
                     rocket: Rocket? = nil) {
        self.init()
        self.launches = launches
        self.rocket = rocket
    }
    var launches: [Launch]?
    func getLaunches() -> Single<[Launch]> {
        return Single.create { [unowned self] (single) -> Disposable in
            guard let launches = self.launches else {
                single(.error(MockError.badRequest))
                return Disposables.create()
            }
            single(.success(launches))
            return Disposables.create()
        }
    }
    var rocket: Rocket?
    func getRocket(id: String) -> Single<Rocket> {
        return Single.create { [unowned self] (single) -> Disposable in
            guard let rocket = self.rocket else {
                single(.error(MockError.badRequest))
                return Disposables.create()
            }
            single(.success(rocket))
            return Disposables.create()
        }
    }
}
