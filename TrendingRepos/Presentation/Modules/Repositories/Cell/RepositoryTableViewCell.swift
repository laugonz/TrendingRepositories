//
//  RepositoryTableViewCell.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import UIKit

struct RepositoryCellViewModel {
    let name: String
    let stars: String
    let forks: String
}

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starsLabel: UILabel!
    @IBOutlet weak var forksLabel: UILabel!

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        contentView.backgroundColor = highlighted ? UIColor.lightGray : UIColor.clear
    }

    func display(_ viewModel: RepositoryCellViewModel) {
        nameLabel.text = viewModel.name
        starsLabel.text = viewModel.stars
        forksLabel.text = viewModel.forks
    }
}

extension RepositoryTableViewCell: ReusableView, NibLoadableView {}
