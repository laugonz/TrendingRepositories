//
//  RepositoriesViewModel.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import Foundation

final class RepositoriesViewModel {

	private let router: RepositoriesRouterProtocol
    private var fetchTrendingRepositoriesUseCase: FetchTrendingRepositoriesUseCaseProtocol

    var activityIndicatorDidChange: ((Bool) -> Void)?
    var respositoriesDidChange: (() -> Void)?
    var errorDidChange: ((String) -> Void)?

    private var repositories = [Repository]()

    required init(router: RepositoriesRouterProtocol, fetchTrendingRepositoriesUseCase: FetchTrendingRepositoriesUseCaseProtocol) {
		self.router = router
        self.fetchTrendingRepositoriesUseCase = fetchTrendingRepositoriesUseCase
	}

    private func fetchTrendingRepositories() {
        activityIndicatorDidChange?(true)

        fetchTrendingRepositoriesUseCase.completion = { [weak self] result in
            guard let self = self else { return }

            self.activityIndicatorDidChange?(false)

            switch result {
            case .success(let repositories):
                self.repositories = repositories
                self.respositoriesDidChange?()
            case .failure:
                self.errorDidChange?("general_error".localized())
            }
        }

        fetchTrendingRepositoriesUseCase.execute()
    }
}

extension RepositoriesViewModel: RepositoriesViewModelProtocol {
    func viewReady() {
        fetchTrendingRepositories()
    }

    func viewDidAppear() {
    }
}
