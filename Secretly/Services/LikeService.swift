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
    
    init(post: Post?){
        guard let post = post, let postId = post.id else {
            self.endpoint = nil
            return
        }
        self.endpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(postId)/likes")
        self.active = post.liked ?? false
    }
    
    mutating func action() -> Bool {
        if self.active {
            endpoint?.delete() { result in
                print("Unliked")
            }
        } else {
            try? endpoint?.create(){ result in
                print("Liked")
            }
        }
        self.active = !self.active
        
        return active
    }
}
