//
//  LaunchDetailsViewModelProtocol.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Foundation
import RxSwift

protocol LaunchDetailsViewModelProtocol {
    var rocket: Observable<RocketViewAdapter> { get }
    var isLoading: Observable<Bool> { get }
    var wikiLink: String? { get }
    func fetch()
}
