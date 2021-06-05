//
//  Credentials.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 04/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct Credentials: Restable {
    let username: String?
    let password: String?
    let token: String?

    var id: String {
        get { "" }
    }

    init(username: String, password: String) {
        self.username = username
        self.password = password
        self.token = nil
    }

    enum CodingKeys: String, CodingKey {
        case token
        case username
        case password
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        token = try container.decode(String.self, forKey: .token)
        username = nil
        password = nil
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(password, forKey: .password)
        try container.encode(username, forKey: .username)
    }
}
