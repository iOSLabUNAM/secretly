//
//  CreatePostService.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 11/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct CreatePostService {
    private let client: HttpClient
    private var endpoint: RestClient<Post>

    init() {
        client = HttpClient(session: URLSession.shared, baseUrl: ApiConfig.baseURL.get()!)
        endpoint = RestClient<Post>(client: client, path: "/api/v1/posts")
    }

    func create(_ model: Post, complete: @escaping (Result<Post?, Error>) -> Void ) {
        try? endpoint.create(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
}
