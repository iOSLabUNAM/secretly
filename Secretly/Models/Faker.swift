//
//  Faker.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 22/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct Faker: Restable {
    let username: String
    let email: String

    func identifier() -> String {
        return ""
    }
}
