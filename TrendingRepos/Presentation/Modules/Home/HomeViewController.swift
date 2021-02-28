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

    override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		viewModel.viewDidAppear()
    }

    private func setupBindings() {
        // Do bindings setup
    }
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        viewModel.didTapEnter()
    }
}
