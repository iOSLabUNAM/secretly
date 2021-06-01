//
//  StorageType.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 29/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

enum StorageType {
    case cache
    case permanent

    var searchPathDirectory: FileManager.SearchPathDirectory {
        switch self {
        case .cache:
            return .cachesDirectory
        default:
            return .documentDirectory
        }
    }

    var url: URL {
        var url = FileManager.default.urls(for: searchPathDirectory, in: .userDomainMask).first!
        let applicationPath = "mx.unam.ioslab.secretly.storage"
        url.appendPathComponent(applicationPath)
        return url
    }

    var path: String {
        return url.path
    }

    func clear() {
        try? FileManager.default.removeItem(at: url)
    }

    func ensureExists() {
        var isDir: ObjCBool = false
        if FileManager.default.fileExists(atPath: path, isDirectory: &isDir) {
            if isDir.boolValue { return }
            clear()
        }
        try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: false, attributes: nil)
    }
}
