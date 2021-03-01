//
//  RepositoriesNetworkClientTests.swift
//  TrendingReposTests
//
//  Created by Laura González on 01/03/2021.
//

import XCTest
@testable import TrendingRepos

// MARK: Verification predicates

typealias VerificationPredicate<T> = (T) -> Bool

func equal<T: Equatable>(to value: T) -> VerificationPredicate<T> {
    return { subject in
        subject == value
    }
}


class RepositoriesNetworkClientTests: XCTestCase {

    struct ResourceAndResponse<A> {
        let resource: Resource<A, NetworkError>
        let response: Result<A, NetworkError>

        init(_ resource: Resource<A, NetworkError>, response: Result<A, NetworkError>) {
            self.resource = resource
            self.response = response
        }
    }

    class SessionMock<A>: Session {
        private var response: ResourceAndResponse<A>
        private var loadIsCalled = 0
        private var loadRawIsCalled = 0

        init(response: ResourceAndResponse<A>) {
            self.response = response
        }

        func load<A>(_ resource: NetworkResource<A>, completion: @escaping (Result<A, NetworkError>) -> Void) where A: Decodable {
            guard let resourceExpected = response.resource as? Resource<A, NetworkError>,
                resourceExpected.request == resource.request else {
                    XCTFail("request is invalid: \(String(describing: resource.request))")
                    return
            }

            loadIsCalled += 1
            switch response.response {
            case .success(let resource):
                // swiftlint:disable force_cast
                completion(.success(resource as! A))
            case .failure(let error):
                completion(.failure(error))
            }
        }

        func verifyLoad(_ predicate: (Int) -> Bool, file: StaticString = #file, line: UInt = #line) {
            XCTAssertTrue(predicate(loadIsCalled), "loadIsCalledAndSucceed", file: file, line: line)
        }
    }

    var sut: RepositoriesNetworkClientProtocol!
    let testHost = "http://www.test.com/"


    override func setUpWithError() throws {
        sut = RepositoriesNetworkClient(host: testHost)
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_getRepositoriesResourceGetsRepositoriesNetwordDto() {
        // given
        let endpoint = String(format: RepositoriesEndpoints.trendingSwift.rawValue)
        let url = URL(string: testHost + endpoint)
        let getRepositoriesResource = NetworkResource<RepositoriesNetworkDTO>(url: url!)

        let items = [
            RepositoryNetworkDTO(id: 1,
                                 name: "1",
                                 description: "1 desc",
                                 owner: RepositoryOwnerDTO(login: "1 login"),
                                 stargazers_count: 1,
                                 watchers: 1,
                                 forks: 1),
            RepositoryNetworkDTO(id: 2,
                                 name: "2",
                                 description: "2 desc",
                                 owner: RepositoryOwnerDTO(login: "2 login"),
                                 stargazers_count: 2,
                                 watchers: 2,
                                 forks: 12)]

        let repositoriesNetworkDTO = RepositoriesNetworkDTO(items: items)

        let sessionMock = SessionMock(response: ResourceAndResponse(getRepositoriesResource,
                                                                    response: .success(repositoriesNetworkDTO)))

        let testEnviroment = Network.default
        testEnviroment.session = sessionMock

        sut = RepositoriesNetworkClient(host: testHost, network: testEnviroment)

        // when
        sut.getTrendingRepositories(completion: { result in
            switch result {
            case .success(let repositoriesDto):
                // then
                XCTAssertEqual(repositoriesDto.items.count, 2)
                XCTAssertEqual(repositoriesDto.items[0].name, "1")
            case .failure:
                XCTFail("Failure not expected")
            }
        })

        // then
        sessionMock.verifyLoad(equal(to: 1))

    }

}
