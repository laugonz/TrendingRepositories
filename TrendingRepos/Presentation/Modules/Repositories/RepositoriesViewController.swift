//
//  RepositoriesViewController.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import UIKit

class RepositoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(RepositoryTableViewCell.self)
        }
    }
    @IBOutlet weak var errorLabel: Label!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var viewModel: RepositoriesViewModelProtocol!

	// MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.viewReady()

    }

    override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    func setupBindings() {
        viewModel.repositoriesDidChange = { [weak self] in
            DispatchQueue.main.async {
                self?.errorLabel.isHidden = true
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
            }
        }

        viewModel.activityIndicatorDidChange = { [weak self] visible in
            DispatchQueue.main.async {
                self?.errorLabel.isHidden = true
                visible ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }
        }

        viewModel.titleDidChange = { [weak self] text in
            DispatchQueue.main.async {
                self?.title = text
            }
        }

        viewModel.errorDidChange = { [weak self] text in
            DispatchQueue.main.async {
                self?.tableView.isHidden = true
                self?.errorLabel.text = text
                self?.errorLabel.isHidden = false
            }
        }
    }
}

extension RepositoriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel.viewModel(index: indexPath.row) else {
            return UITableViewCell()
        }

        let cell = tableView.dequeueReusableCell(RepositoryTableViewCell.self, for: indexPath)
        cell.display(cellViewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelect(index: indexPath.row)
    }
}
