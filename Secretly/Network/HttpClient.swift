//
//  HttpClient.swift
//  Secretly
//
//  Created by LuisE on 2/17/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation

struct HttpClient {
    let session: URLSession
    let baseUrl: String

    typealias ResultResponse = (Result<Data?, Error>) -> Void

    func get(path: String, complete: @escaping ResultResponse) {
        request(method: "get", path: path, body: nil, complete: complete)
    }

    func post(path: String, body: Data?, complete: @escaping ResultResponse) {
        request(method: "post", path: path, body: body, complete: complete)
    }

    func put(path: String, body: Data?, complete: @escaping ResultResponse) {
        request(method: "put", path: path, body: body, complete: complete)
    }

    func delete(path: String, complete: @escaping ResultResponse) {
        request(method: "delete", path: path, body: nil, complete: complete)
    }

    private func request(method: String, path: String, body: Data?, complete: @escaping ResultResponse) {
        guard let req = RequestBuilder.build(baseUrl: self.baseUrl, method: method, path: path, body: body) else {
                    complete(.failure(RequestError.invalidRequest))
                    return
                }

        session.dataTask(with: req) { (data, response, error) in
            if let error = error {
                complete(.failure(error))
                return
            }
            let response = HttpResponse(response: response)
            let result   = response.result(for: data)
            complete(result)
        }.resume()
    }
}
