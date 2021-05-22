//
//  ResponseError.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 22/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

enum ResponseError: Error {
    case invalidResponse
    case clientError
    case serverError
}
