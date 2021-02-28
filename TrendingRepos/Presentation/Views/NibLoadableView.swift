//
//  NibLoadableView.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import UIKit

public protocol NibLoadableView: AnyObject {
    static var nibName: String { get }
    static func instantiate() -> Self
}

public extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }

    static func instantiate() -> Self {
        return UINib(nibName: nibName, bundle: Bundle(for: Self.self))
            .instantiate(withOwner: nil, options: nil)[0] as! Self
    }
}

public extension NibLoadableView where Self: UIViewController {
    static var nibName: String {
        return String(describing: self)
    }

    static func instantiate() -> Self {
        return UINib(nibName: nibName, bundle: Bundle(for: Self.self))
            .instantiate(withOwner: nil, options: nil)[0] as! Self
    }
}
