//
//  LikesService.swift
//  Secretly
//
//  Created by Victor Aceves on 06/08/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct LikesService {
    private var likesEndpoint: RestClient<Like>?
    var liked = false
    
    init(post: Post?){
        guard let post = post, let postId = post.id else {
            likesEndpoint = nil
            return
        }
        likesEndpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(postId)/likes")
        liked = post.liked ?? false
    }
    
    mutating func toggleLike(complete: @escaping (Result<Like?, Error>) -> Void) {
        if liked {
            liked = !liked
            likesEndpoint?.delete { result in
                DispatchQueue.main.async { complete(result) }
            }
        } else {
            liked = !liked
            try? likesEndpoint?.create { result in
                DispatchQueue.main.async { complete(result) }
            }
        }
    }
}
