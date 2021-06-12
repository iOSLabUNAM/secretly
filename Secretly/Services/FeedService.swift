//
//  FeedService.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 11/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct FeedService {
    private let client: HttpClient
    private var endpoint: RestClient<Post>

    init() {
        client = HttpClient(session: URLSession.shared, baseUrl: ApiConfig.baseURL.get()!)
        endpoint = RestClient<Post>(client: client, path: "/api/v1/posts")
    }

    func load(completion: @escaping ([Post]) -> Void) {
        endpoint.list { result in
            guard let posts = try? result.get() else { return }
            DispatchQueue.main.async { completion(posts) }
        }
    }
}
