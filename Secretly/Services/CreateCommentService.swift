//
//  CommentService.swift
//  Secretly
//
//  Created by Samuel Arturo Garrido Sánchez on 2021-07-02.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct CreateCommentService {
    private var endpoint: RestClient<Comment>

    init(post: Post) {
        endpoint = RestClient<Comment>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(post.id ?? 1)/comments")
    }

    func create(_ model: Comment, complete: @escaping (Result<Comment?, Error>) -> Void ) {
        try? endpoint.create(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
}
