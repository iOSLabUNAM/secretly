//
//  LikeService.swift
//  Secretly
//
//  Created by Berenice Medel on 04/09/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation


struct LikeService {
    private var endpoint: RestClient<Like>

    init(post: Post) {
        self.endpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(post.id!)/likes")
    }

    func create(_ model: Like, complete: @escaping (Result<Like?, Error>) -> Void ) {
        try? endpoint.create(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
    
    func delete(_ model: Like, complete: @escaping (Result<Like?, Error>) -> Void ) {
        try? endpoint.delete(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
}
