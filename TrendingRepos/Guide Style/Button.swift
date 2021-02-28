//
//  Button.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import UIKit

class Button: UIButton {
    var titleFont: UIFont?

    var normalTitleColor: UIColor?
    var highlightedTitleColor: UIColor?
    var disabledTitleColor: UIColor?

    var normalBackgroundColor: UIColor?
    var highlightedBackgroundColor: UIColor?
    var disabledBackgroundColor: UIColor?

    var normalBorderColor: UIColor?
    var highlightedBorderColor: UIColor?
    var disabledBorderColor: UIColor?

    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? highlightedBackgroundColor : normalBackgroundColor
            layer.borderColor = isHighlighted ? highlightedBorderColor?.cgColor : normalBorderColor?.cgColor
        }
    }

    override open var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled ? normalBackgroundColor : disabledBackgroundColor
            layer.borderColor = isEnabled ? normalBorderColor?.cgColor : disabledBorderColor?.cgColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureStyle()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        configureStyle()
    }

    // MARK: Configure

    func configureStyle() {
        clipsToBounds = true
        layer.cornerRadius = frame.height / 2

        setTitleColor(normalTitleColor, for: .normal)
        setTitleColor(highlightedTitleColor, for: .highlighted)
        setTitleColor(disabledTitleColor, for: .disabled)

        if normalBorderColor != nil ||
            highlightedBorderColor != nil ||
            disabledBorderColor != nil {
            layer.borderWidth = 1
        }

        switch state {
        case .highlighted:
            backgroundColor = highlightedBackgroundColor
            layer.borderColor = highlightedBorderColor?.cgColor
        case .disabled:
            backgroundColor = disabledBackgroundColor
            layer.borderColor = disabledBorderColor?.cgColor
        default:
            backgroundColor = normalBackgroundColor
            layer.borderColor = normalBorderColor?.cgColor
        }

        //contentEdgeInsets = UIEdgeInsets(top: 8, left: 44, bottom: 8, right: 44)
    }
}

class PrimaryRed: Button {
    override func configureStyle() {
        titleFont = UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.bold)
        
        normalTitleColor = UIColor.white
        highlightedTitleColor = UIColor.white
        disabledTitleColor = UIColor.white

        normalBackgroundColor = Colors.red.color
        highlightedBackgroundColor = Colors.orange.color
        disabledBackgroundColor = UIColor.gray

        super.configureStyle()
    }
}
