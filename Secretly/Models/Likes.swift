//
//  Likes.swift
//  Secretly
//
//  Created by Maria Lacayo on 14/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//
import Foundation

struct Likes: Restable {
    let id: Int?
    let createdAt: String?
    let updatedAt: String?
    var user: User?
    
    init(){
        self.id = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.user = nil
    }
    
}
