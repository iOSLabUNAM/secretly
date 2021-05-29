//
//  Checksum.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 29/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
import CryptoKit

struct Checksum {
    static func sha256(_ content: String) -> String {
        let data = content.data(using: .utf8)!
        let digest = SHA256.hash(data: data)
        return digest.description.components(separatedBy: " ")[2]
    }
}
