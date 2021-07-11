//
//  LikeService.swift
//  Secretly
//
//  Created by Samuel Arturo Garrido Sánchez on 2021-07-11.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

struct LikeService {
    private var endpoint: RestClient<Like>
    
    init(post: Post) {
        self.endpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(post.id ?? 1)/likes")
    }
    
    func create(_ model: Like, complete: @escaping (Result<Like?, Error>) -> Void ) {
        try? endpoint.create(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
    
    func delete(_ model: Like, complete: @escaping (Result<Like?, Error>) -> Void) {
        endpoint.delete(model: model) { result in
                DispatchQueue.main.async { complete(result) }
            }
        }
    
}
