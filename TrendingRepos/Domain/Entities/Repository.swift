//
//  Repository.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let name: String
    let description: String
    let owner: String
    let stars: Int
    let watchers: Int
    let forks: Int
}

extension Repository: Equatable {}
