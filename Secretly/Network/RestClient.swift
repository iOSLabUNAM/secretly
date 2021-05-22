//
//  CodableClient.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 22/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

// REST API ->
// GET    /api/v1/posts(.:format)     #list
// POST   /api/v1/posts(.:format)     #create
// GET    /api/v1/posts/:id(.:format) #show
// PUT    /api/v1/posts/:id(.:format) #update
// DELETE /api/v1/posts/:id(.:format) #destroy

import Foundation

protocol Identifialbe {
    func identifier() -> String
}
protocol Restable: Codable & Identifialbe {}

struct RestClient<T: Restable> {
    let client: HttpClient
    let path: String

    public var decoder = JSONDecoder()
    public var encoder = JSONEncoder()

    func list(complete: @escaping (Result<[T], Error>) -> Void) {
        client.get(path: path) { result in
            let newResult = result.flatMap { parseList(data: $0) }
            complete(newResult)
        }
    }

    func show(complete: @escaping (Result<T?, Error>) -> Void) {
        show("", complete: complete)
    }

    func show(_ identifier: String, complete: @escaping (Result<T?, Error>) -> Void) {
        client.get(path: "\(path)/\(identifier)") { result in
            let newResult = result.flatMap { parse(data: $0) }
            complete(newResult)
        }
    }

    func create(model: T, complete: @escaping (Result<T?, Error>) -> Void) throws {
        let data = try encoder.encode(model)
        client.post(path: path, body: data) { result in
            let newResult = result.flatMap { parse(data: $0) }
            complete(newResult)
        }
    }

    func update(model: T, complete: @escaping (Result<T?, Error>) -> Void) throws {
        let data = try encoder.encode(model)
        client.put(path: "\(path)/\(model.identifier())", body: data) { result in
            let newResult = result.flatMap { parse(data: $0) }
            complete(newResult)
        }
    }

    func delete(model: T, complete: @escaping (Result<T?, Error>) -> Void) {
        client.delete(path: "\(path)/\(model.identifier())") { result in
            let newResult = result.flatMap { parse(data: $0) }
            complete(newResult)
        }
    }

    private func parseList(data: Data?) -> Result<[T], Error> {
        if let data = data {
            return Result { try self.decoder.decode([T].self, from: data) }
        } else {
            return .success([])
        }
    }

    private func parse(data: Data?) -> Result<T?, Error> {
        if let data = data {
            return Result { try self.decoder.decode(T.self, from: data) }
        } else {
            return .success(nil)
        }
    }
}
