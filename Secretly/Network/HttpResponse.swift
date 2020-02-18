//
//  HttpResponse.swift
//  Secretly
//
//  Created by LuisE on 2/17/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation

struct HttpResponse {
    let httpUrlResponse: HTTPURLResponse

    init(response: URLResponse?) {
        self.httpUrlResponse = response as! HTTPURLResponse
    }

    var status: StatusCode {
        get {
            return StatusCode(rawValue: self.httpUrlResponse.statusCode)
        }
    }

    func isSuccessful() -> Bool {
        return status == StatusCode.success
    }
}
