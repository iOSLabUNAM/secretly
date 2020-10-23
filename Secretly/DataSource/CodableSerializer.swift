//
//  CodableSerializer.swift
//  fakestagram
//
//  Created by LuisE on 10/11/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class CodableSerializer<T: Codable> {
    let data: Data?
    let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()

    init(data: Data?) {
        self.data = data
    }

    func async(result: @escaping (T?) -> Void) {
        guard let data = data else {
            DispatchQueue.main.async { result(nil) }
            return
        }
        do {
            let json = try decoder.decode(T.self, from: data)
            DispatchQueue.main.async { result(json) }
        } catch let err {
            print("Invalid JSON format: \(err.localizedDescription)")
        }
    }
}
