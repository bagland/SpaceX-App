//
//  LaunchesViewModel.swift
//  SpaceX Launches
//
//  Created by Baglan Daribayev on 3/7/21.
//

import Foundation
import RxSwift

class LaunchesViewModel: LaunchesViewModelProtocol {
    private let disposeBag = DisposeBag()
    private let launchesSubj = PublishSubject<[LaunchesViewType]>()
    private let isLoadingSubj = BehaviorSubject<Bool>(value: false)
    private let networking: NetworkServiceProtocol
    private let mapper: LaunchMapperProtocol
    
    var launches: Observable<[LaunchesViewType]> {
        launchesSubj.asObservable()
    }
    var isLoading: Observable<Bool> {
        return isLoadingSubj.asObservable()
    }
    
    required init(networking: NetworkServiceProtocol,
                  mapper: LaunchMapperProtocol) {
        self.networking = networking
        self.mapper = mapper
    }
    
    func fetch() {
        isLoadingSubj.onNext(true)
        networking
            .getLaunches()
            .subscribe { [weak self] (launches) in
                self?.isLoadingSubj.onNext(false)
                guard let strSelf = self else { return }
                let items = launches
                    .filter(strSelf.launchFilter(_:))
                    .compactMap(strSelf.mapper.mapToViewAdapter(_:))
                    .map { LaunchesViewType.items(launch: $0) }
                if items.count == 0 {
                    strSelf.launchesSubj.onNext([.empty])
                } else {
                    strSelf.launchesSubj.onNext(items)
                }
            } onError: { [weak self] (error) in
                self?.isLoadingSubj.onNext(false)
                self?.launchesSubj.onNext([.error(message: error.localizedDescription)])
            }.disposed(by: disposeBag)
    }
    
    
    /// Used to filter launch event.
    /// - Parameter launch: launch event entity
    /// - Returns: true if launch event fits filter criterias
    private func launchFilter(_ launch: Launch) -> Bool {
        var isValidDate: Bool = false
        let threeYearsAgo = Calendar.current.date(byAdding: .year, value: -3, to: Date())!
        // launch date is valid if it's not earlier than 3 years.
        isValidDate = launch.launchDate >= threeYearsAgo
        // verify launch event is upcoming or successful and has valid date.
        return (launch.success == .some(true) || launch.upcoming == .some(true)) && isValidDate
    }
}
