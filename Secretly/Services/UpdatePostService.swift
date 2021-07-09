//
//  UpdatePostService.swift
//  Secretly
//
//  Created by Antonio Lara Navarrete on 09/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct UpdatePostService {
    private var endpoint: RestClient<Post>

    init(id: Int) {
        endpoint = RestClient<Post>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(id)")
    }

    func update(_ model: Post, complete: @escaping (Result<Post?, Error>) -> Void ) {
        try? endpoint.update(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
}
