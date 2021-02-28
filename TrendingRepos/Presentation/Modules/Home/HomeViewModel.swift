//
//  HomeViewModel.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import Foundation

final class HomeViewModel {

	private let router: HomeRouterProtocol

	required init(router: HomeRouterProtocol) {
		self.router = router
	}
}

extension HomeViewModel: HomeViewModelProtocol {
    func viewReady() {
        // Called when view is loaded and ready
    }

    func didTapEnter() {
        router.showRepositories()
    }
}
