//
//  Client.swift
//  Secretly
//
//  Created by LuisE on 2/17/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation

class Client {
    static let fakestagram = Client(session: URLSession.shared, baseUrl: "https://secretlyapi.herokuapp.com")
    let session: URLSession
    let baseUrl: String

    init(session: URLSession, baseUrl: String) {
        self.session = session
        self.baseUrl = baseUrl
    }

    typealias SuccessfulResponse = (Data?) -> Void

    func get(path: String, success: @escaping SuccessfulResponse) {
        request(method: "get", path: path, body: nil, success: success)
    }

    func post(path: String, body: Data?, success: @escaping SuccessfulResponse) {
        request(method: "post", path: path, body: body, success: success)
    }

    func put(path: String, body: Data?, success: @escaping SuccessfulResponse) {
        request(method: "put", path: path, body: body, success: success)
    }

    func delete(path: String, success: @escaping SuccessfulResponse) {
        request(method: "delete", path: path, body: nil, success: success)
    }

    private func request(method: String, path: String, body: Data?, success: @escaping SuccessfulResponse) {
        guard let req = buildRequest(method: method, path: path, body: body) else {
            debugPrint("Invalid request")
            return
        }

        session.dataTask(with: req) { (data, response, error) in
            if let error = error {
                debugPrint(error)
                return
            }

            let response = HttpResponse(response: response)
            if response.isSuccessful() {
                success(data)
            } else {
                #if DEBUG
                debugPrint(response.status)
                if let data = data {
                    let error = String(data: data, encoding: .utf8)
                    debugPrint(error)
                }
                #endif
            }
        }.resume()
    }

    private func buildRequest(method: String, path: String, body: Data?) -> URLRequest? {
        var builder = RequestBuilder(baseUrl: self.baseUrl)
        builder.method = method
        builder.path = path
        builder.body = body
        if let token = Credentials.userToken.get() {
            builder.headers = ["Authorization": "Bearer \(token)"]
        }
        return builder.request()
    }
}
