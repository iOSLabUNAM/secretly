//
//  Credentials.swift
//  Secretly
//
//  Created by LuisE on 2/17/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation
import SAMKeychain

enum Credentials {
    case userToken

    func get() -> String? {
        switch self {
        case .userToken:
            return SAMKeychain.password(forService: "mx.unam.secretly", account: "userToken")
        }
    }

    func set(value: String) -> Bool {
        switch self {
        case .userToken:
            SAMKeychain.setPassword(value, forService: "mx.unam.secretly", account: "userToken")
        }
        return true
    }

    func destroy() -> Bool {
        switch self {
        case .userToken:
            SAMKeychain.deletePassword(forService: "mx.unam.secretly", account: "userToken")
        }
        return true
    }
}
