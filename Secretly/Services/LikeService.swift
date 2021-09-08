//
//  LikeService.swift
//  Secretly
//
//  Created by Emanuel Flores Martínez on 06/09/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct LikeService {
    let endpoint: RestClient<Like>?
    
    init(post: Post?) {
        guard let post = post, let postId = post.id else {
            self.endpoint = nil
            return
        }
        self.endpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "api/v1/posts/\(postId)/likes")
    }
    
    func likePost(complete: @escaping(Result<Like?, Error>) -> Void) {
        try? endpoint?.create { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
    
    func dislikePost(complete: @escaping(Result<Like?, Error>) -> Void) {
        endpoint?.delete { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
}
