//
//  FetchTrendingRepositoriesMock.swift
//  TrendingReposTests
//
//  Created by Laura González on 01/03/2021.
//

import Foundation
@testable import TrendingRepos

class FetchTrendingRepositoriesUseCaseMock: FetchTrendingRepositoriesUseCaseProtocol {
    var completion: ((Result<[Repository], RepositoriesUseCaseError>) -> Void)?
    var result: Result<[Repository], RepositoriesUseCaseError>

    init(result: Result<[Repository], RepositoriesUseCaseError> = .success([])) {
        self.result = result
    }

    func execute() {
       completion?(result)
    }
}
