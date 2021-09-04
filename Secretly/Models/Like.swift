//
//  Like.swift
//  Secretly
//
//  Created by Berenice Medel on 04/09/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct Like: Restable {
    let id, userID, postId: Int?
    let createdAt, updatedAt: String?
    
    init(postId: Int){
        self.id = nil
        self.postId = postId
        self.createdAt = nil
        self.updatedAt = nil
        self.userID = nil
    }
}
