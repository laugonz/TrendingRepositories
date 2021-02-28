//
//  RepositoriesViewController.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import UIKit

final class RepositoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(RepositoryTableViewCell.self)
        }
    }

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

    private func setupBindings() {
        viewModel.repositoriesDidChange = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.isHidden = false
                self?.tableView.reloadData()
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
