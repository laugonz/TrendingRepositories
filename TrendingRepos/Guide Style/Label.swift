//
//  Label.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import UIKit

class Label: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyle()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureStyle()
    }

    // MARK: Configure

    func configureStyle() {}
}

// MARK: Headings

class H1WhiteLabel: Label {

    override func configureStyle() {
        font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.medium)
        textColor = UIColor.white
    }
}


class H1DarkGreyLabel: Label {

    override func configureStyle() {
        font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.medium)
        textColor = Colors.darkGrey.color
    }
}

class H2DarkGreyLabel: Label {

    override func configureStyle() {
        font = UIFont.systemFont(ofSize: 22, weight: UIFont.Weight.medium)
        textColor = Colors.darkGrey.color
    }
}

class BodyRegularWhiteLabel: Label {

    override func configureStyle() {
        font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        textColor = UIColor.white
    }
}

class BodyRegularDarkGreyLabel: Label {

    override func configureStyle() {
        font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.regular)
        textColor = Colors.darkGrey.color
    }
}

class BodyBoldWhiteLabel: Label {

    override func configureStyle() {
        font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        textColor = UIColor.white
    }
}

class BodyBoldDarkGreyLabel: Label {

    override func configureStyle() {
        font = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        textColor = Colors.darkGrey.color
    }
}
