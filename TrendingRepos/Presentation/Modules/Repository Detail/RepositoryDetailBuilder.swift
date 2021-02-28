//
//  RepositoryDetailBuilder.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import Foundation

final class RepositoryDetailBuilder: RepositoryDetailBuilderProtocol {

    func build(repository: Repository) -> RepositoryDetailViewController {

		let viewController = RepositoryDetailViewController()
		let router = RepositoryDetailRouter(viewController: viewController)
		let viewModel = RepositoryDetailViewModel(router: router, repository: repository)

		viewController.viewModel = viewModel

		return viewController
	}
}
