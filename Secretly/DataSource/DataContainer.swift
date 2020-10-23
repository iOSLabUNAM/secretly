//
//  DataContainer.swift
//  Secretly
//
//  Created by LuisE on 22/10/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation

// Usage
// DataContainer.cache.write("file.json",data: parsedData)
// DataContainer.cache.read("file.png")
// DataContainer.permanent.write("file.json",data: parsedData)
// DataContainer.permanent.read("file.png")

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

    func read(_ filename: String) -> Data? {
        return try? Data(contentsOf: urlFor(filename: filename))
    }

    func write(_ filename: String, data: Data) -> Bool {
        do {
            try data.write(to: urlFor(filename: filename))
            return true
        } catch let err {
            debugPrint("Error: \(err.localizedDescription)")
            return false
        }
    }

    func urlFor(filename: String) -> URL {
        var url = baseUrl
        url.appendPathComponent(filename)
        return url
    }
}
