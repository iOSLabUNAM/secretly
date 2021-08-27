//
//  Like.swift
//  Secretly
//
//  Created by maxwell on 25/08/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct Like: Restable {
    var id: Int
    let likeableType: String
    let likeableId: Int
    let createdAt: String
    let updatedAt: String
    var user: User
}
