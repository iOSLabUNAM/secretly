//
//  KeychainService.swift
//  Secretly
//
//  Created by Luis Abraham Ortega Gonzalez on 02/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation


struct KeychainStore{
    
    public let serviceName:String?
    
    private static let defaultServiceName: String = {
           return Bundle.main.bundleIdentifier ?? "com.secretly.ioslab"
    }()
    
    public static let common = KeychainStore()
    
    public init(serviceName:String? = nil){
        self.serviceName = serviceName
    }
    
    private init(){
        self.init(serviceName: KeychainStore.defaultServiceName)
    }
    
    

    public func setItem(key :String, value: String, accesibility: CFString? = nil) -> Bool {
        let encodedValue = value.data(using: String.Encoding.utf8)!
        return self.set(key: key, value: encodedValue, accesibility: accesibility)
    }
    
    
    private func set(key :String, value: Data, accesibility: CFString? = nil) -> Bool{
        var query = self.setUpKeychainDic(key: key,accesibility: accesibility)
        
        query[kSecValueData as String] = value
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == errSecSuccess {
            return true
        } else if status == errSecDuplicateItem {
            return self.updateItem(key: key, value: value, accesibility: accesibility)
        } else {
            return false
        }
    }
    
    private func updateItem(key:String, value:Data, accesibility: CFString? = nil) -> Bool {
    
        let query = self.setUpKeychainDic(key: key, accesibility: accesibility)
        let update:[String:Any] = [kSecValueData as String:value]
        
        let status = SecItemUpdate(query as CFDictionary, update as CFDictionary)

        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }
    
    
    public func getItem(forKey key: String) throws -> String{
        var query = self.setUpKeychainDic(key: key)
        query[kSecReturnAttributes as String] =  true
        query[kSecReturnData as String] =  true
        query[kSecMatchLimit as String] =  kSecMatchLimitOne
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        
        guard status != errSecItemNotFound else { throw KeychainError.noItem }
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        
        guard let existingItem = item as? [String : Any],
            let itemData = existingItem[kSecValueData as String] as? Data,
            let stringData = String(data: itemData, encoding: String.Encoding.utf8)
        else {
            throw KeychainError.unexpectedItemData
        }
        
        return stringData
    }
    

    public func deleteItem(forKey key: String, accesibility: CFString? = nil) -> Bool{
        let query = self.setUpKeychainDic(key: key, accesibility: accesibility)
        let status: OSStatus = SecItemDelete(query as CFDictionary)
        if status == errSecSuccess {
            return true
        } else {
            return false
        }
        
    }
    
    public func deleteAllItems() -> Bool {
        var query = [String:Any]()
        query[kSecClass as String] = kSecClassInternetPassword
        query[kSecAttrServer as String] = self.serviceName ??  KeychainStore.defaultServiceName
        
        let status: OSStatus = SecItemDelete(query as CFDictionary)
        if status == errSecSuccess {
            return true
        } else {
            return false
        }
    }
    
    private func setUpKeychainDic(key: String, accesibility: CFString? = nil) -> [String:Any]{
        var keychainQueryDictionary: [String:Any] = [String: Any]()
        // Uniquely identify this keychain accessor
        let encodedIdentifier: Data? = key.data(using: String.Encoding.utf8)
        keychainQueryDictionary[kSecClass as String] = kSecClassInternetPassword
        keychainQueryDictionary[kSecAttrDescription as String] = encodedIdentifier
        keychainQueryDictionary[kSecAttrAccount as String] = encodedIdentifier
        keychainQueryDictionary[kSecAttrServer as String] = self.serviceName ??  KeychainStore.defaultServiceName
        
        if let accessString = accesibility {
            keychainQueryDictionary[kSecAttrAccessible as String] = accessString
        }
        
        
        return keychainQueryDictionary
    }
    
}
