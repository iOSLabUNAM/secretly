//
//  LikeService.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 11/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct LikeService {
    private var likeEndpoint: RestClient<Like>
    private var postId: Int

    init(postId: Int) {
        self.postId = postId
        likeEndpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(self.postId)/like")
    }
    
    func delete(_ model: Like, complete: @escaping (Result<Like?, Error>) -> Void ) {
        likeEndpoint.delete(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
    
    func load(completion: @escaping ([Like]) -> Void) {
        likeEndpoint.list { result in
            guard let likes = try? result.get() else { return }
            DispatchQueue.main.async { completion(likes) }
        }
    }
    
    func create(_ model: Like, complete: @escaping (Result<Like?, Error>) -> Void ) {
        try? likeEndpoint.create(model: model) {
            result in
            DispatchQueue.main.async { complete(result) }
        }
    }
}
