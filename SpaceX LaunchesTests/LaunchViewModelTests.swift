//
//  LaunchViewModelTests.swift
//  SpaceX LaunchesTests
//
//  Created by Baglan Daribayev on 3/8/21.
//

import XCTest
import RxSwift
@testable import SpaceX_Launches

class LaunchViewModelTests: XCTestCase {
    private var sut: LaunchesViewModelProtocol!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLaunchesError() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        sut = LaunchesViewModel(
            networking: MockNetworking(),
            mapper: LaunchMapper())
        let disposeBag = DisposeBag()
        let exp = expectation(description: "expect error item")
        sut.launches.subscribe(onNext: { (launchesViewType) in
            // We expect an error object at first since we didn't set `launches` in our mock networking obj.
            if case .some(.error(_)) = launchesViewType.first {
                exp.fulfill()
            }
        }).disposed(by: disposeBag)
        sut.fetch()
        wait(for: [exp], timeout: 0.05)
    }
    
    func testLaunchesEmpty() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        sut = LaunchesViewModel(
            networking: MockNetworking(launches: []),
            mapper: LaunchMapper())
        let disposeBag = DisposeBag()
        let exp = expectation(description: "expect empty items")
        sut.launches.subscribe(onNext: { (launchesViewType) in
            // We expect an error object at first since we didn't set `launches` in our mock networking obj.
            if case .some(.empty) = launchesViewType.first {
                exp.fulfill()
            }
        }).disposed(by: disposeBag)
        sut.fetch()
        wait(for: [exp], timeout: 0.05)
    }
    
    func testLaunchesNonEmpty() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        sut = LaunchesViewModel(
            networking: MockNetworking(launches: [Launch.mock()]),
            mapper: LaunchMapper())
        let disposeBag = DisposeBag()
        let exp = expectation(description: "expect launches")
        sut.launches.subscribe(onNext: { (launchesViewType) in
            // We expect an error object at first since we didn't set `launches` in our mock networking obj.
            if case .some(.items(_)) = launchesViewType.first {
                exp.fulfill()
            }
        }).disposed(by: disposeBag)
        sut.fetch()
        wait(for: [exp], timeout: 0.05)
    }

    func testLaunchesOlderThanThreeYears() throws {
        let mockLaunch1 = Launch.mock(name: "Space1", dateUtc: "2006-03-17T00:00:00.000Z")
        let mockLaunch2 = Launch.mock(name: "Space2")
        sut = LaunchesViewModel(
            networking: MockNetworking(launches: [mockLaunch1, mockLaunch2]),
            mapper: LaunchMapper())
        let disposeBag = DisposeBag()
        let exp = expectation(description: "expect 1 launch with name Space2")
        sut.launches.subscribe(onNext: { (launchesViewType) in
            // We expect an error object at first since we didn't set `launches` in our mock networking obj.
            if case let .some(.items(launch)) = launchesViewType.first,
               launch.name == "Space2",
               launchesViewType.count == 1 {
                exp.fulfill()
            }
        }).disposed(by: disposeBag)
        sut.fetch()
        wait(for: [exp], timeout: 0.05)
    }
    
    func testLaunchesUpcoming() throws {
        let mockLaunch1 = Launch.mock(name: "Space1", upcoming: true)
        let mockLaunch2 = Launch.mock(name: "Space2", upcoming: false)
        sut = LaunchesViewModel(
            networking: MockNetworking(launches: [mockLaunch1, mockLaunch2]),
            mapper: LaunchMapper())
        let disposeBag = DisposeBag()
        let exp = expectation(description: "expect 1 launch with name Space1")
        sut.launches.subscribe(onNext: { (launchesViewType) in
            // We expect an error object at first since we didn't set `launches` in our mock networking obj.
            if case let .some(.items(launch)) = launchesViewType.first,
               launch.name == "Space1",
               launchesViewType.count == 1 {
                exp.fulfill()
            }
        }).disposed(by: disposeBag)
        sut.fetch()
        wait(for: [exp], timeout: 0.05)
    }
    
    func testLaunchesSuccessNotUpcoming() throws {
        let mockLaunch1 = Launch.mock(name: "Space1", success: false, upcoming: false)
        let mockLaunch2 = Launch.mock(name: "Space2", success: true, upcoming: false)
        let mockLaunch3 = Launch.mock(name: "Space3", success: false, upcoming: false)
        sut = LaunchesViewModel(
            networking: MockNetworking(launches: [mockLaunch1, mockLaunch2, mockLaunch3]),
            mapper: LaunchMapper())
        let disposeBag = DisposeBag()
        let exp = expectation(description: "expect 1 launch with name Space1")
        sut.launches.subscribe(onNext: { (launchesViewType) in
            // We expect an error object at first since we didn't set `launches` in our mock networking obj.
            if case let .some(.items(launch)) = launchesViewType.first,
               launch.name == "Space2",
               launchesViewType.count == 1 {
                exp.fulfill()
            }
        }).disposed(by: disposeBag)
        sut.fetch()
        wait(for: [exp], timeout: 0.05)
    }
    
}

extension Launch {
    static func mock(name: String = "Space1",
                     dateUtc: String = "2021-10-01T00:00:00.000Z",
                     success: Bool? = nil,
                     upcoming: Bool = true) -> Launch {
        .init(
            links: nil,
            rocket: "asdf",
            success: success,
            details: "Nice",
            flightNumber: 1,
            name: name,
            dateUtc: dateUtc,
            upcoming: upcoming,
            id: "1234")
    }
}
