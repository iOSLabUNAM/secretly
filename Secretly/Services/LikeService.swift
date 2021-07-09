//
//  LikeService.swift
//  Secretly
//
//  Created by Administrador on 07/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

// MARK: - Creating a service to handle the " Tap to Like" functionality
struct LikeService {
    let endpoint: RestClient<Like>?
    var active = false
    
    init(post: Post?){
        guard let post = post, let postId = post.id else {
            self.endpoint = nil
            return
        }
        self.endpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(postId)/likes")
        self.active = post.liked ?? false
    }
    
    mutating func action(complete: @escaping (Result<Like?, Error>) -> Void) {
        if self.active {
            self.active = !self.active
            endpoint?.delete() { result in
                DispatchQueue.main.async { complete(result) }
            }
        } else {
            self.active = !self.active
            try? endpoint?.create() { result in
                DispatchQueue.main.async { complete(result) }
            }
        }
    }
}
