//
//  ResponseError.swift
//  Secretly
//
//  Created by Hernán Galileo Cabrera Garibaldi on 22/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

enum ResponseError: Error {
    case invalidRequest
    case clientError
    case serverError
}
