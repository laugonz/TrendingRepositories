//
//  RepositoriesViewControllerMock.swift
//  TrendingReposTests
//
//  Created by Laura González on 01/03/2021.
//

import Foundation

import XCTest
@testable import TrendingRepos

class RepositoriesViewControllerMock: RepositoriesViewController {
    private var errorDidChangeCalled = 0
    private var errorDisplayed: String?

    private var repositoriesDidChangeCalled = 0

    private var activityIndicatorDidChangeCalled = 0
    private var activityIndicatorDisplayed: Bool?

    override func setupBindings() {
        viewModel.errorDidChange = { error in
            self.errorDidChangeCalled += 1
            self.errorDisplayed = error
        }

        viewModel.repositoriesDidChange = {
            self.errorDidChangeCalled += 1
        }

        viewModel.activityIndicatorDidChange = { start in
            self.activityIndicatorDidChangeCalled += 1
            self.activityIndicatorDisplayed = start
        }
    }

    func verifyErrorDidChange(error: String, predicate: VerificationPredicate<Int>, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(error, errorDisplayed, file: file, line: line)
        XCTAssertTrue(predicate(errorDidChangeCalled), file: file, line: line)
    }

    func verifyRepositoriesDidChange(predicate: VerificationPredicate<Int>, file: StaticString = #file, line: UInt = #line) {
        XCTAssertTrue(predicate(repositoriesDidChangeCalled), file: file, line: line)
    }

    func verifyActivityIndicatorDidChange(start: Bool, predicate: VerificationPredicate<Int>, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(start, activityIndicatorDisplayed, file: file, line: line)
        XCTAssertTrue(predicate(activityIndicatorDidChangeCalled), file: file, line: line)
    }
}
