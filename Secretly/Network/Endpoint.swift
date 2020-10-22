//
//  Endpoint.swift
//  It serializes defaul JSON response
//  Secretly
//
//  Created by LuisE on 10/21/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation

struct EmptyResponseError: Error {}
struct SerializingError: Error {}

struct Endpoint<T> where T: Codable {
    let client: Client
    let path: String

    public var encoder: JSONEncoder
    public var decoder: JSONDecoder

    init(client: Client, path: String) {
        self.client = client
        self.path = path
        self.encoder = JSONEncoder()
        self.encoder.keyEncodingStrategy = .convertToSnakeCase
        self.decoder = JSONDecoder()
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    typealias EndpointResponse = (Result<T?, Error>) -> Void

    func all(completion: @escaping (Result<[T]?, Error>) -> Void) {
        client.get(path: path) { response in
            let serializedResponse = response.flatMap { serializeItemList($0) }
            DispatchQueue.main.async { completion(serializedResponse) }
        }
    }

    func find(id: String = "", completion: @escaping EndpointResponse) {
        client.get(path: "\(path)/\(id)") { response in
            let serializedResponse = response.flatMap { serializeItem($0) }
            DispatchQueue.main.async { completion(serializedResponse) }
        }
    }

    func create(codable: T, completion: @escaping EndpointResponse) {
        guard let data = try? encoder.encode(codable) else {
            completion(.failure(SerializingError()))
            return
        }
        client.post(path: path, body: data) { response in
            let serializedResponse = response.flatMap { serializeItem($0) }
            DispatchQueue.main.async { completion(serializedResponse) }
        }
    }

    func update(id: String, codable: T, completion: @escaping EndpointResponse) {
        guard let data = try? encoder.encode(codable) else {
            completion(.failure(SerializingError()))
            return
        }
        client.put(path: "\(path)/\(id)", body: data) { response in
            let serializedResponse = response.flatMap { serializeItem($0) }
            DispatchQueue.main.async { completion(serializedResponse) }
        }
    }

    func destroy(id: String, completion: @escaping EndpointResponse) {
        client.delete(path: "\(path)/\(id)") { response in
            let serializedResponse = response.flatMap { _ -> Result<T?, Error> in
                return .success(nil)
            }
            DispatchQueue.main.async { completion(serializedResponse) }
        }
    }

    private func serializeItem(_ data: Data?) -> Result<T?, Error> {
        guard let data = data else {
            return .failure(EmptyResponseError())
        }
        do {
            let json = try decoder.decode(T.self, from: data)
            return .success(json)
        } catch let err {
            #if DEBUG
            debugPrint(err)
            debugPrint(String(data: data, encoding: .utf8) ?? "")
            #endif
            return .failure(SerializingError())
        }
    }

    private func serializeItemList(_ data: Data?) -> Result<[T]?, Error> {
        guard let data = data else {
            return .failure(EmptyResponseError())
        }
        do {
            let json = try decoder.decode([T].self, from: data)
            return .success(json)
        } catch let err {
            #if DEBUG
            debugPrint(err)
            debugPrint(String(data: data, encoding: .utf8) ?? "")
            #endif
            return .failure(SerializingError())
        }
    }
}
