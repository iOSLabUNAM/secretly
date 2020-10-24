//
//  User.swift
//  Secretly
//
//  Created by LuisE on 10/24/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: Int?
    let username: String
    let avatarUrl: String?
}
