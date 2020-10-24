//
//  Post.swift
//  Secretly
//
//  Created by LuisE on 10/24/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation

struct Post: Codable {
    let id: Int?
    let title: String?
    let commentsCount: Int
    let image: Image?
    let user: User
}
