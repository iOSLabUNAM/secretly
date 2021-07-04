//
//  CommentService.swift
//  Secretly
//
//  Created by Samuel Arturo Garrido Sánchez on 2021-07-03.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct CommentServie {
    private var endpoint: RestClient<Comment>

    init(post: Post) {
        endpoint = RestClient<Comment>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(post.id ?? 1)/comments")
    }

    func load(completion: @escaping ([Comment]) -> Void) {
        endpoint.list { result in
            guard let posts = try? result.get() else { return }
            DispatchQueue.main.async { completion(posts) }
        }
    }
}
