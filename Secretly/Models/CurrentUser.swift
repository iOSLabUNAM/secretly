//
//  CurrentUser.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 04/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

class CurrentUser {
    static func load() -> CurrentUser? {
        guard let username = try? KeychainStore.common.getItem(forKey: "secretly.username") else {
            return nil
        }
        return CurrentUser(username: username)
    }

    let username: String

    init(username: String) {
        self.username = username
        _ = KeychainStore.common.setItem(key: "secretly.username", value: username)
    }

    func credentials() -> Credentials {
        if let psswd = password() {
            return Credentials(username: username, password: psswd)
        } else {
            return Credentials(username: username, password: genPassword())
        }
    }

    private func password() -> String? {
        return try? KeychainStore.common.getItem(forKey: "secretly.password")
    }

    private func genPassword() -> String {
        let newPsswd = UUID().uuidString
        _ = KeychainStore.common.setItem(key: "secretly.password", value: newPsswd)
        return newPsswd
    }
}
