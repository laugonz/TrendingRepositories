//
//  RepositoriesBuilder.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import Foundation

final class RepositoriesBuilder: RepositoriesBuilderProtocol {

	func build() -> RepositoriesViewController {

		let viewController = RepositoriesViewController()
		let router = RepositoriesRouter(viewController: viewController)
        let networkClient = RepositoriesNetworkClient()
        let repository = RepositoriesRepository(remoteDataSource: networkClient)
        let useCase = FetchTrendingRepositoriesUseCase(repository: repository)
        let viewModel = RepositoriesViewModel(router: router, fetchTrendingRepositoriesUseCase: useCase)

		viewController.viewModel = viewModel

		return viewController
	}
}
