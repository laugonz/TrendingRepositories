//
//  RepositoriesUseCase.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import Foundation

enum RepositoriesUseCaseError: Error {
    case noData
    case parseError
    case generalError

    init(repoError error: RepoError) {
        switch error {
        case .parseError:
            self = .parseError
        default:
            self = .generalError
        }
    }
}

protocol FetchTrendingRepositoriesUseCaseProtocol: UseCase {
    var completion: ((Result<[Repository], RepositoriesUseCaseError>) -> Void)? { get set }
}

final class FetchTrendingRepositoriesUseCase {
    let repository: RepositoriesRepositoryProtocol
    var completion: ((Result<[Repository], RepositoriesUseCaseError>) -> Void)?

    init(repository: RepositoriesRepositoryProtocol) {
        self.repository = repository
    }
}

extension FetchTrendingRepositoriesUseCase: FetchTrendingRepositoriesUseCaseProtocol {
    func execute() {
        repository.fetchRepositories { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.completion?(.success(repositories))
            case .failure(let error):
                self?.completion?(.failure(RepositoriesUseCaseError(repoError: error)))
            }
        }
    }
}
