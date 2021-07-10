//
//  Author.swift
//  Secretly
//
//  Created by Yocelin Garcia Romero on 25/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

struct Author: Restable {
    let name: String?
    let id: String?

    init(id: String, name: String) {
        self.name = name
        self.id = id
    }
}
