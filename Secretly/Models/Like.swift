//
//  Like.swift
//  Secretly
//
//  Created by Victor Aceves on 06/08/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

struct Like: Restable {
    let id: Int
    let likeableType: String
    let likeableId: Int
    let createdAt: String
    let updatedAt: String
    let user: User
}
