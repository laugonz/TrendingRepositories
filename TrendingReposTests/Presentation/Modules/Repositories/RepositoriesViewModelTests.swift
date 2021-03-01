//
//  RepositoriesViewModelTests.swift
//  TrendingReposTests
//
//  Created by Laura González on 01/03/2021.
//

import XCTest
@testable import TrendingRepos

class RepositoriesViewModelTests: XCTestCase {

    var sut: RepositoriesViewModel!
    var router: RepositoriesRouterMock!
    var fetchTrendingRepositoriesUseCase: FetchTrendingRepositoriesUseCaseProtocol!
    var view: RepositoriesViewControllerMock!

    override func setUp() {
        router = RepositoriesRouterMock()
        fetchTrendingRepositoriesUseCase = FetchTrendingRepositoriesUseCaseMock(result: .success([Repository.defaultMock, Repository.defaultMock2, Repository.defaultMock3]))

        sut = RepositoriesViewModel(router: router,
                                    fetchTrendingRepositoriesUseCase: fetchTrendingRepositoriesUseCase)
        view = RepositoriesViewControllerMock()
        view.viewModel = sut
    }

    override func tearDown() {
        sut = nil
        router = nil
        view = nil
    }

    // MARK: Initialization

    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }

    // MARK: ViewModel

    func testViewReadySuccessCallsRepositoriesDidChange() {
        let expectation = XCTestExpectation(description: "repositoriesDidChange")

        sut.repositoriesDidChange = {
            // then
            expectation.fulfill()
        }
        // when
        sut.viewReady()
        wait(for: [expectation], timeout: 1.0)
    }

    func testViewReadyFailureCallsErrorDidChange() {

        //given
        let expectation = XCTestExpectation(description: "errorDidChange")
        fetchTrendingRepositoriesUseCase = FetchTrendingRepositoriesUseCaseMock(result: .failure(.generalError))
        sut = RepositoriesViewModel(router: router,
                                     fetchTrendingRepositoriesUseCase: fetchTrendingRepositoriesUseCase)
        view = RepositoriesViewControllerMock()
        view.viewModel = sut

        sut.errorDidChange = { error in
            //then
            expectation.fulfill()
        }
        // when
        sut.viewReady()
        wait(for: [expectation], timeout: 1.0)
    }

    func testViewReadyFetchProducts() {
        // given

        // when
        sut.viewReady()

        // then
        XCTAssertEqual(sut.repositoriesCellViewModel.count, 3)
    }
}
