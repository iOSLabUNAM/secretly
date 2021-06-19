//
//  Faker.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 22/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
import Amaca

struct Faker {
    let username: String
    let email: String
}

extension Faker: Restable {
    var id: String { "" }
}
