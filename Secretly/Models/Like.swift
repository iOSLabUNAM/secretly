//
//  Like.swift
//  Secretly
//
//  Created by Antonio Lara Navarrete on 09/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
struct Like:Restable {
    let id: Int?
    let createdAt: Date?
    let updatedAt: Date?
    init(id:Int?,createdAt:Date?,updatedAt:Date?) {
        self.id=id
        self.createdAt=createdAt
        self.updatedAt=updatedAt
    }
    
    
}
