//
//  RepositoryNetworkDTO.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import Foundation

struct RepositoryOwnerDTO: Codable {
    let login: String
}

struct RepositoryNetworkDTO: Codable {
    let id: Int
    let name: String
    let description: String
    let owner: RepositoryOwnerDTO
    let stargazers_count: Int
    let watchers: Int
    let forks: Int
}

enum RepositoryNetworkMapperDTO {

    static func toBO(dto: RepositoryNetworkDTO) -> Repository {
        return Repository(id: dto.id,
                          name: dto.name,
                          description: dto.description,
                          owner: dto.owner.login,
                          stars: dto.stargazers_count,
                          watchers: dto.watchers,
                          forks: dto.forks)
    }

    static func toDTO(obj: Repository) -> RepositoryNetworkDTO {
        return RepositoryNetworkDTO(id: obj.id,
                                    name: obj.name,
                                    description: obj.description,
                                    owner: RepositoryOwnerDTO(login: obj.owner),
                                    stargazers_count: obj.stars,
                                    watchers: obj.watchers,
                                    forks: obj.forks)
    }
}
