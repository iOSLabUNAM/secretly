//
//  Keychain.swift
//  SecretlyTests
//
//  Created by Luis Abraham Ortega Gonzalez on 03/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import XCTest

@testable import Secretly


class KeychainStoreTest: XCTestCase {
    let serviceName = "test.secretly"
    let testString = "testString"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let encodedIdentifier = self.testString.data(using: .utf8)
        let encodedValue = self.testString.data(using: .utf8)
        var query:[String:Any] = [:]
        query[kSecClass as String] = kSecClassInternetPassword
        query[kSecAttrServer as String] = "test.secretly"
        query[kSecAttrDescription as String] = encodedIdentifier
        query[kSecAttrAccount as String] = encodedIdentifier
        query[kSecValueData as String] = encodedValue
        
        _ = SecItemAdd(query as CFDictionary, nil)
    }
    
    override func tearDownWithError() throws {
        var query:[String:Any] = [:]
        query[kSecClass as String] = kSecClassInternetPassword
        query[kSecAttrServer as String] = "test.secretly"
        
        let status: OSStatus = SecItemDelete(query as CFDictionary)

    }
    
    
    func testSaveValueToKeychain(){
        let test = "string1"
        let keychain = KeychainStore(serviceName:self.serviceName)
        
        let result = keychain.setItem(key:test, value:test)
        
        XCTAssertTrue(result)
    }
    
    
    func testReadValueFromKeyChain(){
        let keychain = KeychainStore(serviceName:self.serviceName)
        
        
        let result = try? keychain.getItem(forKey: self.testString)
        XCTAssertEqual(result, self.testString)
 
    }
    
    func testUpdateValueInKeychain(){
        let value = "test2"
        let keychain = KeychainStore(serviceName:self.serviceName)
        
        let updated = keychain.setItem(key: self.testString, value: value)
        
        XCTAssertTrue(updated)
        let result = try? keychain.getItem(forKey: self.testString)
        XCTAssertEqual(result, value)
        
    }
    
    
    func testReadNoValueFromKeyChain(){
        let keychain = KeychainStore(serviceName:self.serviceName)
        let key = "test2"
        
        XCTAssertThrowsError(try keychain.getItem(forKey: key)) {
            switch $0{
            case KeychainError.noItem:
                XCTAssertTrue(true)
            default:
                XCTAssertTrue(false)
            }
        }
    }
    
    
    func testDeleteAnItemFromKeyChain(){
        let keychain = KeychainStore(serviceName:self.serviceName)
        
        let result = keychain.deleteItem(forKey:self.testString)
        
        XCTAssertTrue(result)
        XCTAssertThrowsError(try keychain.getItem(forKey: self.testString))
    }
    
    
    func testDeleteAllValuesFromKeyChain(){
        let keychain = KeychainStore(serviceName:self.serviceName)
        
        let result = keychain.deleteAllItems()
        XCTAssertTrue(result)
        XCTAssertThrowsError(try keychain.getItem(forKey: self.testString))
    }
    
    

}

