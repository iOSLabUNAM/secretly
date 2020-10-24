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
}
