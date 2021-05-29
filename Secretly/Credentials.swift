//
//  Credentials.swift
//  Secretly
//
//  Created by LuisE on 2/17/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation

enum Credentials {
    case userToken

    func get() -> String? {
        switch self {
        case .userToken:
            return nil
        }
    }

    func set(value: String) -> Bool {
        switch self {
        case .userToken:
            return true
        }
        return true
    }

    func destroy() -> Bool {
        switch self {
        case .userToken:
            return true
        }
        return true
    }
}
