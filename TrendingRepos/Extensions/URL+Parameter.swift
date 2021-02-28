//
//  URL+Parameter.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import Foundation

extension URL {

    func appending(_ queryItem: String, value: String?) -> URL? {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: queryItem, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }

    func appending(parameters: [String: Any]?) -> URL {
        guard let parameters = parameters as? [String: String] else { return self }

        var appendingUrl = self
        let sortedParameters = parameters.sorted {$0.key < $1.key}

        for (key, value) in sortedParameters {
            if let url = appendingUrl.appending(key, value: value) {
                appendingUrl = url
            }
        }

        return appendingUrl
    }
}
