//
//  ProfileService.swift
//  Secretly
//
//  Created by Yocelin Garcia Romero on 13/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct UserProfileService {
    let endpoint: RestClient<User>?

    init() {
        endpoint = RestClient<User>(client: AmacaConfig.shared.httpClient, path: "/api/v1/profile")
    }

    func showProfile(completion: @escaping (User) -> Void) {
        endpoint?.show { result in
            guard let userProfile = try? result.get() else { return }
            DispatchQueue.main.async { completion(userProfile) }
        }
    }
}
