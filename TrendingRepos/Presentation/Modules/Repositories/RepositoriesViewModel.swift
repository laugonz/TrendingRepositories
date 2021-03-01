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
    var titleDidChange: ((String) -> Void)?
    var repositoriesDidChange: (() -> Void)?
    var errorDidChange: ((String) -> Void)?

    private var repositories = [Repository]()
    var repositoriesCellViewModel = [RepositoryCellViewModel]()


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
                self.repositoriesCellViewModel = repositories.map {
                    RepositoryCellViewModel(name: $0.owner + "/" + $0.name,
                                            stars: String($0.stars),
                                            forks: String($0.forks))
                }
                self.repositoriesDidChange?()
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

        titleDidChange?("repositories".localized())
    }

    func numberOfItems() -> Int {
        return repositoriesCellViewModel.count
    }

    func viewModel(index: Int) -> RepositoryCellViewModel? {
        guard index < repositoriesCellViewModel.count else { return nil }

        return repositoriesCellViewModel[index]
    }

    func didSelect(index: Int) {
        guard index < repositories.count else { return }

        router.showDetail(repository: repositories[index])
    }

}
