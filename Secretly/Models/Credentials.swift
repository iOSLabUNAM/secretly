//
//  Credentials.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 04/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct Credentials: Restable {
    let username: String?
    let password: String?
    let token: String?

    var id: String {
        get { "" }
    }

    init(username: String, password: String) {
        self.username = username
        self.password = password
        self.token = nil
    }

//    init(from decoder: Decoder) throws {
//        solamente vamos a codifgicar token
//        let token = try? decoder.container(keyedBy: )
//    }
//    func encode(to encoder: Encoder) throws {
//        solamente username y password
//    }
}
