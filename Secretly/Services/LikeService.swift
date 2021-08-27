//
//  LikeService.swift
//  Secretly
//
//  Created by maxwell on 25/08/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct LikeService {
    let endPoint: RestClient<Like>?
    var active = false
    
    init(post: Post?) {
        guard let post = post, let postId = post.id else {
            self.endPoint = nil
            return
        }
        self.endPoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(postId)/likes")
        self.active = post.liked ?? false
    }
    
    mutating func action(complete: @escaping (Result<Like?, Error>)-> Void){
        if self.active {
            endPoint?.delete{ result in
                DispatchQueue.main.async { complete(result) }
            }
        } else {
            try? endPoint?.create{ result in
                DispatchQueue.main.async { complete(result) }
            }
        }
        active = !active
    }
}
