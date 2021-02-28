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

    var titleDidChange: ((String) -> Void)? { get set }
    var bodyDidChange: ((String) -> Void)? { get set }
    var buttonDidChange: ((String) -> Void)? { get set }
    var termsDidChange: ((NSAttributedString) -> Void)? { get set }
    var webDidChange: ((String) -> Void)? { get set }
}

protocol HomeRouterProtocol {
    func showRepositories()
}

protocol HomeBuilderProtocol {
    func build() -> HomeViewController
}

