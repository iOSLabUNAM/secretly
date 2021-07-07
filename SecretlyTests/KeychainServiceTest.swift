//
//  Keychain.swift
//  SecretlyTests
//
//  Created by Luis Abraham Ortega Gonzalez on 03/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import XCTest

@testable import Secretly

class KeychainServiceTest: XCTestCase {
    
    var keychain : KeychainService?
    let testString = "testString"
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.keychain = KeychainService(serviceName:"test.secretly")
        let encodedIdentifier = self.testString.data(using: .utf8)
        let encodedValue = self.testString.data(using: .utf8)
        var query:[String:Any] = [:]
        query[kSecClass as String] = kSecClassInternetPassword
        query[kSecAttrServer as String] = "test.secretly"
        query[kSecAttrDescription as String] = encodedIdentifier
        query[kSecAttrAccount as String] = encodedIdentifier
        query[kSecValueData as String] = encodedValue
        
        let status = SecItemAdd(query as CFDictionary, nil)
        

    
        
    }
    
    override func tearDownWithError() throws {
        var query:[String:Any] = [:]
        query[kSecClass as String] = kSecClassInternetPassword
        query[kSecAttrServer as String] = "test.secretly"
        
        let status: OSStatus = SecItemDelete(query as CFDictionary)
        self.keychain = nil

    }
    
    
    func testSaveValueToKeychain(){
        let result = self.keychain?.setItem(key:"string1", value:"string1")
        
        XCTAssertTrue(result ?? false)
    }
    
    
    func testReadValueFromKeyChain(){
        do {
            let result = try self.keychain?.getItem(forKey: self.testString)
            XCTAssertEqual(result, self.testString)
        } catch {
            print("Ocurrió un error durante la lectura \(error.localizedDescription) ")
        }
    }
    
    func testDeleteAnItemFromKeyChain(){
        let result = self.keychain?.deleteItem(forKey:self.testString)
        XCTAssertTrue(result ?? false)
        var thrownError:Error? = nil
        XCTAssertThrowsError(try self.keychain?.getItem(forKey: self.testString)) {
            thrownError = $0
        }
    }
    
    
    func testDeleteAllValuesFromKeyChain(){
        let result = self.keychain?.deleteAllItems()
        XCTAssertTrue(result ?? false)
        var thrownError:Error? = nil
        XCTAssertThrowsError(try self.keychain?.getItem(forKey: self.testString)) {
            thrownError = $0
        }
    }
    
    

}
