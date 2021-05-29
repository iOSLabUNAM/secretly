//
//  Post.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 28/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct Post: Restable {
    let id: Int
    let content: String
    let backgroundColor: String
    let image: Image?
    let user: User
    let commentsCount: Int
    let createdAt: Date
    let updatedAt: Date
}
