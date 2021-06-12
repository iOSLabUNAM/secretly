//
//  CurrentUserService.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 04/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct CurrentUserService {
    private let client: HttpClient
    private var fakeEndpoint: RestClient<Faker>
    private var signInEndpoint: RestClient<Credentials>
    private var signUpEndpoint: RestClient<Credentials>

    init() {
        client = HttpClient(session: URLSession.shared, baseUrl: ApiConfig.baseURL.get()!)
        fakeEndpoint = RestClient<Faker>(client: client, path: "/api/v1/fake")
        signInEndpoint = RestClient<Credentials>(client: client, path: "/api/v1/sign_in")
        signUpEndpoint = RestClient<Credentials>(client: client, path: "/api/v1/sign_up")
    }

    func auth(_ completion: @escaping (CurrentUser) -> Void) {
        if let currentUser = CurrentUser.load() {
            signIn(currentUser) { completion($0) }
            return
        }
        fakeEndpoint.show { result in
            guard let fake = try? result.get() else { return }
            let currentUser = CurrentUser(username: fake.username)
            signUp(currentUser) { completion($0) }
        }
    }

    private func signUp(_ currentUser: CurrentUser, completion: @escaping (CurrentUser) -> Void) {
        try? signUpEndpoint.create(model: currentUser.credentials()) { result in
            storeToken(result)
            DispatchQueue.main.async {  completion(currentUser) }
        }
    }

    private func signIn(_ currentUser: CurrentUser, completion: @escaping (CurrentUser) -> Void) {
        try? signInEndpoint.create(model: currentUser.credentials()) { result in
            storeToken(result)
            DispatchQueue.main.async {  completion(currentUser) }
        }
    }

    fileprivate func storeToken(_ result: Result<Credentials?, Error>) {
        guard let res = try? result.get(), let token = res.token else { return }
        _ = ApiConfig.token.set(token)
    }
}
