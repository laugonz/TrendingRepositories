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

    //var activityIndicatorDidChange: ((Bool) -> Void)? { get set }
}

protocol RepositoriesRouterProtocol {
}

protocol RepositoriesBuilderProtocol {
    func build() -> RepositoriesViewController
}
