//
//  AuthUser.swift
//  Secretly
//
//  Created by LuisE on 10/24/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation

struct AuthUser: Codable {
    let username: String?
    let password: String?
    let token: String?

    private enum EncodingKeys: String, CodingKey {
        case username
        case password
    }

    private enum DecodingKeys: String, CodingKey {
        case token
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DecodingKeys.self)
        self.token = try container.decode(String?.self, forKey: .token)
        self.username = nil
        self.password = nil
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: EncodingKeys.self)
        try container.encode(String(self.username ?? ""), forKey: .username)
        try container.encode(String(self.password ?? ""), forKey: .password)
    }
}
