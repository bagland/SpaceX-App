//
//  LaunchesViewModelProtocol.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Foundation
import RxSwift

protocol LaunchesViewModelProtocol {
    // Observable of LaunchesViewType items.
    var launches: Observable<[LaunchesViewType]> { get }
    // Observable of loading state.
    var isLoading: Observable<Bool> { get }
    // Fetches launch events.
    func fetch()
}
