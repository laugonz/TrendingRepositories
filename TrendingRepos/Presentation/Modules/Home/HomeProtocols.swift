//
//  HomeProtocols.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import Foundation

protocol HomeViewModelProtocol {
    func viewReady()
    func didTapEnter()
}

protocol HomeRouterProtocol {
    func showRepositories()
}

protocol HomeBuilderProtocol {
    func build() -> HomeViewController
}

