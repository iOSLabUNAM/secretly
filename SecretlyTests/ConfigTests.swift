//
//  Config.swift
//  SecretlyTests
//
//  Created by LuisE on 10/21/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import XCTest
@testable import Secretly

class ConfigTests: XCTestCase {
    func testApiValue() throws {
        XCTAssertEqual("https://secretlyapi.herokuapp.com/", Config.api.value)
    }
}
