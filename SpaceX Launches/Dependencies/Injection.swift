//
//  Injection.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Foundation
import Swinject

enum Injection {
    static let container: Container = Container()
        .registerServices()
        .registerViewModels()
}

private extension Container {
    func registerServices() -> Self {
        register(NetworkServiceProtocol.self) { _ in
            return NetworkService()
        }
        register(LaunchMapperProtocol.self) { _ in
            return LaunchMapper()
        }
        register(RocketMapperProtocol.self) { _ in
            return RocketMapper()
        }
        return self
    }
    func registerViewModels() -> Self {
        register(LaunchDetailsViewModelProtocol.self) { (resolver, rocketId: String) -> LaunchDetailsViewModelProtocol in
            let networking = resolver.resolve(NetworkServiceProtocol.self)!
            let mapper = resolver.resolve(RocketMapperProtocol.self)!
            return LaunchDetailsViewModel(
                networking: networking,
                mapper: mapper,
                rocketId: rocketId)
        }
        return self
    }
}
