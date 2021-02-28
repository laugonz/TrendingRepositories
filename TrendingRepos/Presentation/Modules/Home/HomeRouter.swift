//
//  HomeRouter.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import Foundation
import UIKit

final class HomeRouter {
	private weak var viewController: UIViewController?

	required init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension HomeRouter: HomeRouterProtocol {
    func showRepositories() {
        let controller = RepositoriesBuilder().build()
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
