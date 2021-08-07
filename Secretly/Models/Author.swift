//
//  Author.swift
//  Secretly
//
//  Created by Victor Aceves on 06/08/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

struct Author: Restable {
    let name: String?
    let id: String?

    init(id: String, name: String){
        self.name = name
        self.id = id
    }
}
