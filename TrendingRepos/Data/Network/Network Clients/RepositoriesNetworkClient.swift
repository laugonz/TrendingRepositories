//
//  RepositoriesNetworkClient.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import Foundation

protocol RepositoriesNetworkClientProtocol {
    func getTrendingRepositories(completion: @escaping (Result<RepositoriesNetworkDTO, NetworkError>) -> Void)
}

enum RepositoriesEndpoints: String {
    case trendingSwift = "repositories?q=swift&sort=stars"
}

class RepositoriesNetworkClient {
    private let host: String
    private let network: Network

    init(host: String = NetworkConstants.host, network: Network = Network.default) {
        self.host = host
        self.network = network
    }
}

extension RepositoriesNetworkClient: RepositoriesNetworkClientProtocol {
    func getTrendingRepositories(completion: @escaping (Result<RepositoriesNetworkDTO, NetworkError>) -> Void) {
        guard let url = URL(string: host + RepositoriesEndpoints.trendingSwift.rawValue) else {
            preconditionFailure("getTrendingRepositories: URL not valid")
        }

        let resource = (NetworkResource<RepositoriesNetworkDTO>(url: url))
        network.session.load(resource, completion: completion)
    }
}
