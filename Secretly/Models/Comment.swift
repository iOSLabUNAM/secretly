//
//  Comment.swift
//  Secretly
//
//  Created by Maria Lacayo on 23/08/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct Comment: Restable {
    var id: Int?
    var createdAt: String?
    var updatedAt: String?
    var autor: User?
    var content: String?
    
    init(){
        self.id = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.autor = nil
        self.content = nil
    }
    
}

