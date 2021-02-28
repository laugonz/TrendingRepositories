//
//  RepositoriesRouter.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import Foundation
import UIKit

final class RepositoriesRouter {
	private weak var viewController: UIViewController?

	required init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension RepositoriesRouter: RepositoriesRouterProtocol {
    func showDetail(repository: Repository) {
        let controller = RepositoryDetailBuilder().build(repository: repository)
        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
