//
//  Api.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 04/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

enum ApiConfig {
    case token
    case baseURL

    func get() -> String? {
        switch self {
        case .token:
            // TODO: obtener desde keychain
            return UserDefaults.standard.string(forKey: "secretly.token")
        case .baseURL:
            return "https://secretlyapi.herokuapp.com"
        }
    }

    func set(_ value: String) -> Bool {
        print(value)
        switch self {
        case .token:
            // TODO : Store in keychain
            UserDefaults.standard.set(value, forKey: "secretly.token")
            return true
        default:
            return false
        }
    }
}
