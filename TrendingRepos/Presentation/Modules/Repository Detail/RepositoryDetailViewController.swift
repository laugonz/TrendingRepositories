//
//  RepositoryDetailViewController.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import UIKit

final class RepositoryDetailViewController: UIViewController {

	var viewModel: RepositoryDetailViewModelProtocol!

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!
    
    // MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.viewReady()

    }

    override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
    }

    private func setupBindings() {
        viewModel.nameDidChange = { [weak self] text in
            DispatchQueue.main.async {
                self?.nameLabel.text = text
            }
        }

        viewModel.descriptionDidChange = { [weak self] text in
            DispatchQueue.main.async {
                self?.descriptionLabel.text = text
            }
        }

        viewModel.starsDidChange = { [weak self] text in
            DispatchQueue.main.async {
                self?.starsLabel.text = text
            }
        }

        viewModel.forksDidChange = { [weak self] text in
            DispatchQueue.main.async {
                self?.forksLabel.text = text
            }
        }
    }
}
