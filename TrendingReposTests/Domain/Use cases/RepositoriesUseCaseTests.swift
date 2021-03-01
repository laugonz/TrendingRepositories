//
//  RepositoriesUseCaseTests.swift
//  TrendingReposTests
//
//  Created by Laura González on 01/03/2021.
//

import XCTest
@testable import TrendingRepos

class RepositoriesUseCaseTests: XCTestCase {

    class RepositoriesSuccessRepositoryMock: RepositoriesRepositoryProtocol {
        let repositories: [Repository]

        init(repositories: [Repository] = [Repository.defaultMock, Repository.defaultMock2, Repository.defaultMock3]) {
            self.repositories = repositories
        }


        func fetchRepositories(completion: @escaping (Result<[Repository], RepoError>) -> Void) {
            completion(.success(repositories))
        }
    }

    class RepositoriesFailureRepositoryMock: RepositoriesRepositoryProtocol {
        let error: RepoError

        init(error: RepoError) {
            self.error = error
        }

        func fetchRepositories(completion: @escaping (Result<[Repository], RepoError>) -> Void) {
            completion(.failure(error))
        }
    }


    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchRepositoriesUseCaseSuccess() throws {

        // Given
        var repositoriesReceived: [Repository] = []
        let repositoriesExpected = [Repository.defaultMock, Repository.defaultMock2, Repository.defaultMock3]
        let repository = RepositoriesSuccessRepositoryMock()
        let sut = FetchTrendingRepositoriesUseCase(repository: repository)
        sut.completion = { result in
            if case .success(let repositories) = result {
                repositoriesReceived = repositories
            } else {
                XCTFail("Expecting a success result")
            }
        }

        // When
        sut.execute()

        // Then
        XCTAssertEqual(repositoriesReceived, repositoriesExpected, "Repositories received differs from expected")
    }

    func testFetchRepositoriesUseCaseFailure() throws {

        // Given
        var errorReceived: RepositoriesUseCaseError?
        let errorExpected = RepositoriesUseCaseError.generalError
        let repository = RepositoriesFailureRepositoryMock(error: .generalError)
        let sut = FetchTrendingRepositoriesUseCase(repository: repository)
        sut.completion = { result in
            if case .failure(let error) = result {
                errorReceived = error
            } else {
                XCTFail("Expecting a failure result")
            }
        }

        // When
        sut.execute()

        // Then
        XCTAssertEqual(errorReceived, errorExpected, "Error received differs from expected")
    }
}
