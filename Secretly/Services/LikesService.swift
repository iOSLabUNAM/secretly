//
//  LikesService.swift
//  Secretly
//
//  Created by Maria Lacayo on 14/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//
import Foundation

struct LikesService {
    private var endpoint: RestClient<Likes>
    var liked = false
    
    init(post: Post?) {
        self.endpoint = RestClient<Likes>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(post?.id ?? 0)/likes")
        liked = post?.liked ?? false
    }
    
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
    }
    
}
