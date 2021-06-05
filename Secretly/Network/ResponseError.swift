//
//  ResponseError.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 22/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

protocol Titleable {
    var title: String { get }
}

enum ResponseError: Error, Titleable {
    case invalidResponse
    case clientError
    case serverError

    var title: String {
        switch self {
        case .invalidResponse:
            return "Invalid Response"
        case .clientError:
            return "Client error"
        case .serverError:
            return "Internal Server error"
        }
    }
}
