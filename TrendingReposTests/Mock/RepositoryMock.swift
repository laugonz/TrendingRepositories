//
//  RepositoryMock.swift
//  TrendingReposTests
//
//  Created by Laura González on 01/03/2021.
//

import Foundation

@testable import TrendingRepos

extension Repository {

    static let defaultMock = Repository(id: 1, name: "1", description: "1", owner: "owner 1", stars: 1, watchers: 1, forks: 1)

    static let defaultMock2 = Repository(id: 2, name: "2", description: "2", owner: "owner 2", stars: 2, watchers: 2, forks: 2)

    static let defaultMock3 = Repository(id: 3, name: "3", description: "3", owner: "owner 3", stars: 3, watchers: 3, forks: 3)
}
