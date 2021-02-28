//
//  RepositoriesProtocols.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import Foundation

protocol RepositoriesViewModelProtocol {
    func viewReady()
    func viewDidAppear()

    func numberOfItems() -> Int
    func viewModel(index: Int) -> RepositoryCellViewModel?
    func didSelect(index: Int)

    var activityIndicatorDidChange: ((Bool) -> Void)? { get set }
    var repositoriesDidChange: (() -> Void)? { get set }
    var errorDidChange: ((String) -> Void)? { get set }
}

protocol RepositoriesRouterProtocol {
    func showDetail(repository: Repository)
}

protocol RepositoriesBuilderProtocol {
    func build() -> RepositoriesViewController
}
