//
//  Network.swift
//  TrendingRepos
//
//  Created by Laura González on 28/02/2021.
//

import Foundation

public enum ContentType {
    case json
    case xml
    case image
    case form
    case custom(contentType: String)
    case defaultInMethod(_ method: Method)
    case none

    public var rawValue: String? {
        switch self {
        case .json: return "application/json"
        case .xml: return "text/xml; charset=utf-8"
        case .image: return "image/jpeg"
        case .form: return "application/x-www-form-urlencoded"
        case .defaultInMethod(let method):
            if method == .post || method == .put {
                return "application/json"
            }
            return nil
        case .custom(let contentType):
            return contentType
        case .none:
            return nil
        }
    }
}

public enum Method: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public struct Resource<A, E: Error> {
    public let url: URL
    var method: Method = Method.get
    var body: Data?
    let contentType: ContentType?
    var parse: ((Data) -> Result<A, E>)?
    var headers: [String: String]?
}

public enum NetworkError: Error {
    case parseError
    case invalidResponse
    case network(error: Error)
    case failure(statusCode: Int)
}

public typealias NetworkResource<A: Decodable> = Resource<A, NetworkError>

extension Data {
    func decode<T: Decodable>(_ type: T.Type) -> T? {
        return try? JSONDecoder().decode(T.self, from: self)
    }
}

public enum DataEncoder {
    public static func encodeJSON(_ parameters: [String: Any]) -> Data? {
        return try? JSONSerialization.data(withJSONObject: parameters, options: [])
    }

    public static func encode<T>(_ info: T) -> Data? where T: Encodable {
         return try? JSONEncoder().encode(info)
    }
}

public extension NetworkResource where A: Decodable, E == NetworkError {
    init(url: URL, method: Method = .get, queryParameters: [String: String]? = nil, contentType: ContentType? = nil, body: Data? = nil, headers: [String: String]? = nil) {
        self.method = method
        self.url = url.appending(parameters: queryParameters)
        self.body = body
        self.contentType = contentType == nil ? .defaultInMethod(method) : contentType
        self.headers = headers

        self.parse = { data in
            if let result = try? JSONDecoder().decode(A.self, from: data) {
                return .success(result)
            } else {
                return .failure(.parseError)
            }
        }
    }

    var request: URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if method == .post || method == .put {
            urlRequest.httpBody = body
        }

        if let contentType = contentType?.rawValue {
            urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        }

        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        return urlRequest
    }
}

public class Network {
    public var session: Session

    public static let `default`: Network = {
        return Network()
    }()

    public init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }
}

public protocol Session {
    func load<A>(_ resource: NetworkResource<A>, completion: @escaping (Result<A, NetworkError>) -> Void)
}

extension URLSession: Session {
    public func load<A>(_ resource: NetworkResource<A>, completion: @escaping (Result<A, NetworkError>) -> Void) {
        let responseHandler = { (data: Data?, response: URLResponse?, error: Error?) in

            if let error = error {
                completion(.failure(.network(error: error)))
                return
            }

            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            if let data = data, let parse = resource.parse {
                switch parse(data) {
                case .success(let result):
                    completion(.success(result))
                case .failure(let error):
                    completion(.failure(error))
                }
            } else {
                if (200..<300).contains(response.statusCode) {
                    completion(.failure(.invalidResponse))
                } else {
                    completion(.failure(.failure(statusCode: response.statusCode)))
                }
            }
        }

        dataTask(with: resource.request, completionHandler: responseHandler).resume()
    }
}
