//
//  RepositoryDetailProtocols.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import Foundation

protocol RepositoryDetailViewModelProtocol {
    func viewReady()

    var nameDidChange: ((String) -> Void)? { get set }
    var descriptionDidChange: ((String) -> Void)? { get set }
    var starsDidChange: ((String) -> Void)? { get set }
    var forksDidChange: ((String) -> Void)? { get set }
}

protocol RepositoryDetailRouterProtocol {
}

protocol RepositoryDetailBuilderProtocol {
    func build(repository: Repository) -> RepositoryDetailViewController
}
