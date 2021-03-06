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
            UserDefaults.standard.string(forKey: "amaca.apitoken")
        }
    }

    func setApiToken(_ value: String) {
        UserDefaults.standard.set(value, forKey: "amaca.apitoken")
    }

    private var filepath: String {
        return Bundle.main.path(forResource: "Amaca", ofType: "plist")!
    }

    private var values: NSDictionary {
        return NSDictionary(contentsOfFile: filepath)!
    }
}
