//
//  CommentService.swift
//  Secretly
//
//  Created by Maria Lacayo on 23/08/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct CommentService {
    private var endpoint: RestClient<Comment>
    var comment = 0
    
    init(post: Post?) {
        self.endpoint = RestClient<Comment>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(post?.id ?? 0)/comments")
        comment = post?.commentsCount ?? 0
    }
    /*
    mutating func setLike(complete: @escaping (Result<Likes?, Error>) -> Void) {
        if liked {
            liked = !liked
            endpoint.delete { result in
                DispatchQueue.main.async { complete(result) }
            }
        } else {
            print("ENTRE A NO LIKE")
            liked = !liked
            try? endpoint.create { result in
                DispatchQueue.main.async { complete(result) }
            }
        }
    }*/
    
}
