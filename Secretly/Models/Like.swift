//
//  Like.swift
//  Secretly
//
//  Created by Administrador on 07/07/21.
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
