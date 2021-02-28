//
//  RepositoryDetailViewModel.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import Foundation

final class RepositoryDetailViewModel {

	private let router: RepositoryDetailRouterProtocol
    private let repository: Repository

    var nameDidChange: ((String) -> Void)?
    var descriptionDidChange: ((String) -> Void)?
    var starsDidChange: ((String) -> Void)?
    var forksDidChange: ((String) -> Void)?

    required init(router: RepositoryDetailRouterProtocol, repository: Repository) {
		self.router = router
        self.repository = repository
	}
}

extension RepositoryDetailViewModel: RepositoryDetailViewModelProtocol {
    func viewReady() {
        nameDidChange?(repository.owner + "/" + repository.name)
        descriptionDidChange?(repository.description)
        starsDidChange?(String(repository.stars))
        forksDidChange?(String(repository.forks))
    }
}
