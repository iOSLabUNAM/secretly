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
        guard let username = UserDefaults.standard.string(forKey: "secretly.username") else {
            return nil
        }
        return CurrentUser(username: username)
    }

    let username: String

    init(username: String) {
        self.username = username
        UserDefaults.standard.set(username, forKey: "secretly.username")
    }

    func credentials() -> Credentials {
        if let psswd = password() {
            return Credentials(username: username, password: psswd)
        } else {
            return Credentials(username: username, password: genPassword())
        }
    }

    private func password() -> String? {
        return UserDefaults.standard.string(forKey: "secretly.password")
    }

    private func genPassword() -> String {
        let newPsswd = UUID().uuidString
        UserDefaults.standard.set(newPsswd, forKey: "secretly.password")
        return newPsswd
    }
}
