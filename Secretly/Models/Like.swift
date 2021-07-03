//
//  Like.swift
//  Secretly
//
//  Created by Yocelin Garcia Romero on 25/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

struct Like: Restable {
    let id, userID: Int
    let likeableType: String
    let likeableID: Int
    let createdAt, updatedAt: String
}

