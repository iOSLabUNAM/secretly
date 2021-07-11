//
//  Comment.swift
//  Secretly
//
//  Created by Samuel Arturo Garrido Sánchez on 2021-07-02.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

struct Comment: Restable{
    var id: Int?
    var autor:User?
    var createdAt:Date?
    var uptadedAt:Date?
    var content:String
    // autor: User? = nil, createdAt: Date? = nil, uptadedAt: Date? = nil
    init(content: String){
        self.id = nil
        self.autor = nil
        self.createdAt = nil
        self.uptadedAt = nil
        self.content = content
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(content, forKey: .content)
    }
}
