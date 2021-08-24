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
        self.httpUrlResponse = (response as? HTTPURLResponse) ?? HTTPURLResponse()
    }

    var status: StatusCode {
        return StatusCode(rawValue: self.httpUrlResponse.statusCode)
    }

    func result(for data: Data?) -> Result<Data?, Error> {
        //debugPrint("Response: \(status) \(httpUrlResponse.statusCode)")
        //return status.result().map { _ in data }
        
        // #if DEGUB
        if let udata = data, !udata.isEmpty {
            let currentData = String(data: udata, encoding: .utf8)
            debugPrint("Response: \(status) \(httpUrlResponse.statusCode) \(httpUrlResponse.url!) -d \(String(describing: currentData))")
        } else {
            debugPrint("Response: \(status) \(httpUrlResponse.statusCode) \(httpUrlResponse.url!)")
        }
        // #endif
        if let udata = data, !udata.isEmpty {
            return status.result().map { _ in data }
        } else {
            return status.result().map { _ in nil }
        }
    }
}
