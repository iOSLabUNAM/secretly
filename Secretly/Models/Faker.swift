//
//  Faker.swift
//  Secretly
//
//  Created by Hernán Galileo Cabrera Garibaldi on 22/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct Faker {
    let username: String
    let email: String
}

extension Faker: Restable{
    var id: String{
        ""
    }
}
