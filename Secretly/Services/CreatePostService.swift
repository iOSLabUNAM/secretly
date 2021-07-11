//
//  CreatePostService.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 11/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct CreatePostService {
    private var endpoint: RestClient<Post>

    init() {
        endpoint = RestClient<Post>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts")
    }

    func create(_ model: Post, complete: @escaping (Result<Post?, Error>) -> Void ) {
        try? endpoint.create(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
}
