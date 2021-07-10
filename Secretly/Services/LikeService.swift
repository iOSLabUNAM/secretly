//
//  LikeService.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 11/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct LikeService {
    let endpoint: RestClient<Like>?
    var active = false

    init(post: Post?) {
        guard let post = post, let postId = post.id else {
            endpoint = nil
            return
        }
        endpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(postId)/likes")
        active = post.liked ?? false
    }

    mutating func action(complete: @escaping (Result<Like?, Error>) -> Void) {
        if active {
            active = !active
            endpoint?.delete { result in
                DispatchQueue.main.async { complete(result) }
            }
        } else {
            active = !active
            try? endpoint?.create { result in
                DispatchQueue.main.async { complete(result) }
            }
        }
    }
}
