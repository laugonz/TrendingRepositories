//
//  ReusableView.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import UIKit

public protocol ReusableView: AnyObject {
    static var defaultReuseIdentifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
}
