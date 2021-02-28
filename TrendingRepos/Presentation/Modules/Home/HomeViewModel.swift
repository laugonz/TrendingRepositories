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

    var titleDidChange: ((String) -> Void)?
    var bodyDidChange: ((String) -> Void)?
    var buttonDidChange: ((String) -> Void)?
    var termsDidChange: ((NSAttributedString) -> Void)?
    var webDidChange: ((String) -> Void)?

	required init(router: HomeRouterProtocol) {
		self.router = router
	}
}

extension HomeViewModel: HomeViewModelProtocol {
    func viewReady() {
        titleDidChange?("welcome".localized())
        bodyDidChange?("welcome_body".localized())
        buttonDidChange?("enter".localized())
        webDidChange?("go_to_web".localized())

        let terms = NSMutableAttributedString(string: "privacy_and_terms".localized())
        terms.underline("privacy".localized())
        terms.underline("terms".localized())
        termsDidChange?(terms)
    }

    func didTapEnter() {
        router.showRepositories()
    }
}
