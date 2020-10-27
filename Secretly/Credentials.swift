//
//  Credentials.swift
//  Secretly
//
//  Created by LuisE on 2/17/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation

enum Credentials {
    static let serviceName = "com.3zcurdia.secretly"
    case username
    case userToken

    func get() -> String? {
        switch self {
        case .username:
            return UserDefaults.standard.string(forKey: "username")
        case .userToken:
            guard let username = UserDefaults.standard.string(forKey: "username") else { return nil }
            return try? KeychainPasswordItem(service: Credentials.serviceName, account: username).readPassword()
        }
    }

    func set(value: String) -> Bool {
        switch self {
        case .username:
            UserDefaults.standard.set(value, forKey: "username")
            return true
        case .userToken:
            guard let username = UserDefaults.standard.string(forKey: "username") else { return false }
            do {
                try KeychainPasswordItem(service: Credentials.serviceName, account: username).savePassword(value)
                return true
            } catch let err {
                #if DEBUG
                debugPrint(err)
                #endif
                return false
            }
        }
    }

    func destroy() -> Bool {
        switch self {
        case .username:
            UserDefaults.standard.removeObject(forKey: "username")
            return true
        case .userToken:
            guard let username = UserDefaults.standard.string(forKey: "username") else { return false }
            do {
                try KeychainPasswordItem(service: Credentials.serviceName, account: username).deleteItem()
                return true
            } catch let err {
                #if DEBUG
                debugPrint(err)
                #endif
                return false
            }
        }
    }
}
