//
//  Like.swift
//  Secretly
//
//  Created by Emanuel Flores Martínez on 06/09/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct Like: Restable {
    let id: Int?
    let createdAt: String?
    let updatedAt: String?
    
    init() {
        self.id = nil
        self.createdAt = nil
        self.updatedAt = nil
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
    }
}
