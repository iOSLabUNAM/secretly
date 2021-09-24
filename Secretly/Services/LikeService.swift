//
//  LikeService.swift
//  Secretly
//
//  Created by Orlando Ortega on 09/09/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct LikeService {
    var likeEndpoint: RestClient<Like>?
    var isLiked = false
    
    init(post: Post?) {
        guard let post = post, let postId = post.id else {
            self.likeEndpoint = nil
            return
        }
        self.likeEndpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(postId)/like")
        isLiked = post.liked ?? false
    }
    
    mutating func likeOrDislikePost(complete: @escaping(Result<Like?, Error>) -> Void) {
        if !isLiked {
            isLiked = !isLiked
            try? likeEndpoint?.create(complete: { (res) in
                DispatchQueue.main.async {
                    complete(res)
                }
            })
        } else {
            isLiked = !isLiked
            try? likeEndpoint?.delete(complete: { (res) in
                DispatchQueue.main.async {
                    complete(res)
                }
            })
        }
    }
}
