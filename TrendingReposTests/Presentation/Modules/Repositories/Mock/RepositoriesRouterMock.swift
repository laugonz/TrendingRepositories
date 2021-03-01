//
//  RepositoriesRouterMock.swift
//  TrendingReposTests
//
//  Created by Laura González on 01/03/2021.
//

import Foundation
import XCTest
@testable import TrendingRepos

class RepositoriesRouterMock: RepositoriesRouterProtocol {
    private var showDetailIsCalled: Int = 0

    func showDetail(repository: Repository) {
        showDetailIsCalled += 1
    }


    func verifyShowDetail(predicate: VerificationPredicate<Int>, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(predicate(showDetailIsCalled), file: file, line: line)
    }
}
