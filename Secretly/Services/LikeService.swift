//
//  LikeService.swift
//  Secretly
//
//  Created by Proteco on 10/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct LikeService {
    private var endpoint: RestClient<Like>?
    
    init(post: Post?) {
        guard let post = post, let postId = post.id else {
            self.endpoint = nil
            return
        }
        self.endpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(postId)/likes")
    }
    
    init(id: Int?) {
        guard let postId = id else {
            self.endpoint = nil
            return
        }
        self.endpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(postId)/likes")
    }
    
    func create(_ model: Like, complete: @escaping (Result<Like?, Error>) -> Void) {
        try? endpoint?.create() { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
    
    func delete(_ model: Like, complete: @escaping (Result<Like?, Error>) -> Void) {
        try? endpoint?.delete() { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
    
}
