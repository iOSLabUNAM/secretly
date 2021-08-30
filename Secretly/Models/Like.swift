//
//  Like.swift
//  Secretly
//
//  Created by Hernán Galileo Cabrera Garibaldi on 27/08/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//
/*
 [
   {
     "author": {
       "name": "fugiat",
       "id": "8a41d660-04fc-05f4-232c-f607a462d841"
     },
     "created_at": "1954-11-24T06:42:25.586Z",
     "updated_at": "1970-08-07T11:31:10.325Z"
   }
 ]
 */

import Foundation

struct Like: Restable {
    var id: Int
    let likeableType: String
    let likeableId: Int
    let createdAt, updatedAt: String
    var user: User
}
