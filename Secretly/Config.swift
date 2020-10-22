//
//  Config.swift
//  Secretly
//
//  Created by LuisE on 10/21/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation

enum Config {
    case api

    var value: String {
        switch self {
        case .api:
            return "https://secretlyapi.herokuapp.com/api/v1/"
        }
    }
}
