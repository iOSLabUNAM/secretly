//
//  AmacaConfig.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 18/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct AmacaConfig {
    static let shared = AmacaConfig()
    var host: String {
        values["host"] as! String
    }
    var httpClient: HttpClient {
        HttpClient(session: URLSession.shared, baseUrl: host)
    }

    var apiToken: String? {
        get {
            try? KeychainStore.common.getItem(forKey: "amaca.apitoken")
            
        }
    }

    func setApiToken(_ value: String) {
        _ = KeychainStore.common.setItem(key: "amaca.apitoken", value: value)
    }

    private var filepath: String {
        return Bundle.main.path(forResource: "Amaca", ofType: "plist")!
    }

    private var values: NSDictionary {
        return NSDictionary(contentsOfFile: filepath)!
    }
}
