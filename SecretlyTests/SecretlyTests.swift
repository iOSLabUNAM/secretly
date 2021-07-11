//
//  SecretlyTests.swift
//  SecretlyTests
//
//  Created by LuisE on 2/16/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import XCTest
import UIKit
@testable import Secretly

class SecretlyTests: XCTestCase {
    
    
    func checkUserLoged() {
        let currentUser = CurrentUser.load()?.username
        let username = UserDefaults.standard.string(forKey: "secretly.username")
        XCTAssertEqual(currentUser, username)
    }
    
    func testCreateLike() {
        let createLike = CommentService(post: Post(content: "Hola", backgroundColor: "#FFFFFF"))
             XCTAssertNoThrow(createLike)
    }
    
    func checkSumComments(){
        CommentService.countByID(id: 78) { comments in
            XCTAssertEqual(comments.count, 13)
        }
    }
}
