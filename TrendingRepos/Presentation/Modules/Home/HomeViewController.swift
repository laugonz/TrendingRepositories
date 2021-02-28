//
//  HomeViewController.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import UIKit

final class HomeViewController: UIViewController {

	var viewModel: HomeViewModelProtocol!

	// MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.viewReady()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    private func setupBindings() {
        // Do bindings setup
    }
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        viewModel.didTapEnter()
    }
}
