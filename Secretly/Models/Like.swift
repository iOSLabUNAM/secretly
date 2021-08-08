//
//  Like.swift
//  Secretly
//
//  Created by mac on 31/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct Like: Restable {
    var id :  Int?
    let createdAt : Date
    let updateAt : Date
    let user : User
}

