//
//  ProfileService.swift
//  Secretly
//
//  Created by Maria Lacayo on 23/08/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct ProfileService {
    let endpoint: RestClient<Profile>

    
    init() {
        endpoint = RestClient<Profile>(client: AmacaConfig.shared.httpClient, path: "/api/v1/profile")
    }
    
     func setProfile(complete: @escaping (Profile) -> Void) {
        endpoint.show { result in
            guard let profile = try? result.get() else { return }
            DispatchQueue.main.async { complete(profile) }
        }
    }
    
}
