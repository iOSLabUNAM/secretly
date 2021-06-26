//
//  Like.swift
//  Secretly
//
//  Created by Yocelin Garcia Romero on 25/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

struct Like {
    let author: Author?
    let createdAt: Date?
    let updatedAt: Date?
    
    init(createdAt: Date, updatedAt: Date) {
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.author = nil
    }
}

extension Like: Restable {
    var id: String { "" }
}
