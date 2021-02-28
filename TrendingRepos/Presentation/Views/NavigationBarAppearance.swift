//
//  NavigationBarAppearance.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import UIKit

enum NavigationBarAppearance {

    public static func setup(prefersLargeTitles: Bool = false) {

        let appearance = UINavigationBarAppearance()

        let backgroundColor: UIColor
        let foregroundColor: UIColor

        backgroundColor = UIColor.white
        foregroundColor = Colors.blue.color

        appearance.backgroundColor = backgroundColor
        appearance.titleTextAttributes = [.foregroundColor: foregroundColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor]

        UINavigationBar.appearance().tintColor = foregroundColor
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
