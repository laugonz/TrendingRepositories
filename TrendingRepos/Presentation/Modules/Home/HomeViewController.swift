//
//  HomeViewController.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//  
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var bodyLabel: Label!
    @IBOutlet weak var enterButton: Button!
    @IBOutlet weak var termsLabel: Label!
    @IBOutlet weak var webLabel: Label!

    @IBOutlet weak var logoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var enterButtonBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var enterButtonHeightConstraint: NSLayoutConstraint!

    var viewModel: HomeViewModelProtocol!

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

	// MARK: LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel.viewReady()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        if self.view.bounds.height < 828 {
            logoTopConstraint.constant = 28
        } else {
            logoTopConstraint.constant = 120
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateButton()
    }

    private func animateButton() {
        enterButtonBottomConstraint.constant = 16
        enterButtonHeightConstraint.constant = 60

        UIView.animate(withDuration: 0.5,
                       delay: 0.2,
                       usingSpringWithDamping: 0.4,
                       initialSpringVelocity: 0.7,
                       options: .curveEaseInOut) { [weak self] in
            guard let self = self else { return }
            self.view.layoutIfNeeded()
        } completion: { [weak self] completion in
            self?.enterButtonHeightConstraint.constant = 48

            UIView.animate(withDuration: 0.4,
                           delay: 0.2,
                           usingSpringWithDamping: 0.4,
                           initialSpringVelocity: 0.3,
                           options: .curveEaseInOut) { [weak self] in
                guard let self = self else { return }
                self.view.layoutIfNeeded()
            } completion: { completion in

            }
        }
    }

    private func setupBindings() {
        viewModel.titleDidChange = { [weak self] text in
            DispatchQueue.main.async {
                self?.titleLabel.text = text
            }
        }

        viewModel.bodyDidChange = { [weak self] text in
            DispatchQueue.main.async {
                self?.bodyLabel.text = text
            }
        }

        viewModel.buttonDidChange = { [weak self] text in
            DispatchQueue.main.async {
                self?.enterButton.setTitle(text, for: .normal)
            }
        }

        viewModel.termsDidChange = { [weak self] text in
            DispatchQueue.main.async {
                self?.termsLabel.attributedText = text
            }
        }

        viewModel.webDidChange = { [weak self] text in
            DispatchQueue.main.async {
                self?.webLabel.text = text
            }
        }
    }
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        viewModel.didTapEnter()
    }
}
