//
//  RepositoryDetailRouter.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import Foundation
import UIKit

final class RepositoryDetailRouter {
	private weak var viewController: UIViewController?

	required init(viewController: UIViewController?) {
        self.viewController = viewController
    }
}

extension RepositoryDetailRouter: RepositoryDetailRouterProtocol {

}
