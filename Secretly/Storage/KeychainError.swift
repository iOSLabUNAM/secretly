//
//  KeychainError.swift
//  Secretly
//
//  Created by Luis Abraham Ortega Gonzalez on 10/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

enum KeychainError: Error {
    case noItem
    case unexpectedItemData
    case unhandledError(status: OSStatus)
}
