//
//  DataContainer.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 29/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

enum DataContainer {
    case cache
    case permanent

    var baseUrl: URL {
        switch self {
        case .cache:
            return StorageType.cache.url
        case .permanent:
            return StorageType.permanent.url
        }
    }

    private func urlFor(filename: String) -> URL {
        var url = baseUrl
        url.appendPathComponent(filename)
        return url
    }

    func read(_ filename: String) -> Data? {
        return try? Data(contentsOf: urlFor(filename: filename))
    }

    func write(_ filename: String, data: Data) -> Bool {
        do {
            try data.write(to: urlFor(filename: filename))
            return true
        } catch let err {
            debugPrint("Error while writting(\(filename): \(err.localizedDescription)")
            return false
        }
    }
}
