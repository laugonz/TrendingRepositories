//
//  String+Localized.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import Foundation

extension String {

    public func localized(tableName: String? = nil, bundle: Bundle = .main) -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: "**\(self)**", comment: "")
    }
}
