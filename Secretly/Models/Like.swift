//
//  Like.swift
//  Secretly
//
//  Created by Orlando Ortega on 09/09/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct Like: Restable {
    let id: Int
    let createdAt, updatedAt: String
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
    }
}
