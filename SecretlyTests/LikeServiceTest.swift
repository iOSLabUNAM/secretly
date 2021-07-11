//
//  LikeServiceTest.swift
//  SecretlyTests
//
//  Created by Proteco on 10/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import XCTest
@testable import Secretly

class LikeServiceTest: XCTestCase {
    
    func testCreateLike() {
        let createLike = LikeService(id: 70)
        XCTAssertNoThrow(createLike)
    }
    
    func testDelteTest() {
        let deleteLike = LikeService(id: 70)
        XCTAssertNoThrow(deleteLike)
    }
    
}
