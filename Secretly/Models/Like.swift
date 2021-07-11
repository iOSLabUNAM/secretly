//
//  Like.swift
//  Secretly
//
//  Created by Samuel Arturo Garrido Sánchez on 2021-07-11.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct Like: Restable {
    let id: Int?
    let createdAt: Date?
    let updatedAt: Date?
    
    init(){
        self.id = nil
        self.createdAt = nil
        self.updatedAt = nil
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
    }
}
