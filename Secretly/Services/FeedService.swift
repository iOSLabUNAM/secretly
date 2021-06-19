//
//  FeedService.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 11/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct FeedService {
    private var endpoint: RestClient<Post>

    init() {
        endpoint = RestClient<Post>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts")
    }

    func load(completion: @escaping ([Post]) -> Void) {
        endpoint.list { result in
            guard let posts = try? result.get() else { return }
            DispatchQueue.main.async { completion(posts) }
        }
    }
}
