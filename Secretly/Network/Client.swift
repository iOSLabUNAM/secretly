//
//  Client.swift
//  Secretly
//
//  Created by LuisE on 2/17/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation

struct InvalidRequestError: Error {}
struct InvalidResponseError: Error {}
struct ResponseClientError: Error {}
struct ResponseServerError: Error {}

class Client {
    static let fakestagram = Client(session: URLSession.shared, baseUrl: Config.api.value)
    let session: URLSession
    let baseUrl: String

    init(session: URLSession, baseUrl: String) {
        self.session = session
        self.baseUrl = baseUrl
    }

    typealias Response = (Result<Data?, Error>) -> Void

    func get(path: String, completion: @escaping Response) {
        request(method: "get", path: path, body: nil, completion: completion)
    }

    func post(path: String, body: Data?, completion: @escaping Response) {
        request(method: "post", path: path, body: body, completion: completion)
    }

    func put(path: String, body: Data?, completion: @escaping Response) {
        request(method: "put", path: path, body: body, completion: completion)
    }

    func delete(path: String, completion: @escaping Response) {
        request(method: "delete", path: path, body: nil, completion: completion)
    }

    private func request(method: String, path: String, body: Data?, completion: @escaping Response) {
        guard let req = buildRequest(method: method, path: path, body: body) else {
            completion(.failure(InvalidRequestError()))
            return
        }

        session.dataTask(with: req) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpUrlResponse = response as? HTTPURLResponse else {
                completion(.failure(InvalidResponseError()))
                return
            }

            let status = StatusCode(rawValue: httpUrlResponse.statusCode)
            switch status {
            case .success:
                completion(.success(data))
            case .clientError:
                completion(.failure(ResponseClientError()))
            case .serverError:
                completion(.failure(ResponseServerError()))
            default:
                completion(.failure(InvalidResponseError()))
            }
        }.resume()
    }

    private func buildRequest(method: String, path: String, body: Data?) -> URLRequest? {
        var request = Request(baseUrl: self.baseUrl)
        request.method = method
        request.path = path
        request.body = body
        if let token = Credentials.userToken.get() {
            request.headers = ["Authorization": "Bearer \(token)"]
        }
        return request.urlRequest
    }
}
