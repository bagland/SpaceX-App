//
//  LaunchDetailsViewModel.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Foundation
import RxSwift

class LaunchDetailsViewModel: LaunchDetailsViewModelProtocol {
    private let disposeBag = DisposeBag()
    private let rocketSubj = PublishSubject<RocketViewAdapter>()
    private let isLoadingSubj = BehaviorSubject<Bool>(value: false)
    private let networking: NetworkServiceProtocol
    private let mapper: RocketMapperProtocol
    private let rocketId: String
    var rocket: Observable<RocketViewAdapter> {
        rocketSubj.asObservable()
    }
    var isLoading: Observable<Bool> {
        isLoadingSubj.asObservable()
    }
    var wikiLink: String?
    
    required init(networking: NetworkServiceProtocol,
                  mapper: RocketMapperProtocol,
                  rocketId: String) {
        self.networking = networking
        self.mapper = mapper
        self.rocketId = rocketId
    }
    
    func fetch() {
        isLoadingSubj.onNext(true)
        networking
            .getRocket(id: rocketId)
            .subscribe { [weak self] (rocket) in
                self?.isLoadingSubj.onNext(false)
                guard let viewAdapter = self?.mapper.mapToViewAdapter(rocket)
                else { return }
                self?.rocketSubj.onNext(viewAdapter)
                self?.wikiLink = rocket.wikipedia
            } onError: { [weak self] (error) in
                self?.isLoadingSubj.onNext(false)
            }.disposed(by: disposeBag)
    }
}
