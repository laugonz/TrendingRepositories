//
//  RepositoriesRepository.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import Foundation

public enum RepoError: Error {
    case noData
    case parseError
    case generalError
}

protocol RepositoriesRepositoryProtocol {
    func fetchRepositories(completion: @escaping (Result<[Repository], RepoError>) -> Void)
}

final class RepositoriesRepository {
    let remoteDataSource: RepositoriesNetworkClientProtocol

    init(remoteDataSource: RepositoriesNetworkClientProtocol) {
        self.remoteDataSource = remoteDataSource
    }
}

extension RepositoriesRepository: RepositoriesRepositoryProtocol {
    func fetchRepositories(completion: @escaping (Result<[Repository], RepoError>) -> Void) {
        remoteDataSource.getTrendingRepositories { result in
            switch result {
            case .success(let networkRepositories):
                let repositories = networkRepositories.items.map { RepositoryNetworkMapperDTO.toBO(dto: $0) }
                completion(.success(repositories))
            case .failure:
                completion(.failure(.generalError))
            }
        }
    }
}
