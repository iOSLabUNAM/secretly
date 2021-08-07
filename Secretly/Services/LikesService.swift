//
//  LikesService.swift
//  Secretly
//
//  Created by Victor Aceves on 06/08/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct LikesService {
    private var likesEndpoint: RestClient<Like>
    
    init(postId: Int){
        likesEndpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(postId)/like")
    }
    
    func get(completion: @escaping ([Like]) -> Void) {
        likesEndpoint.list { result in
            guard let likes = try? result.get() else { return }
            DispatchQueue.main.async { completion(likes) }
        }
    }
    
    func add(_ model: Like, complete: @escaping (Result<Like?, Error>) -> Void ) {
        try? likesEndpoint.create(model: model) {
            result in
            DispatchQueue.main.async { complete(result) }
        }
    }
    
    func delete(_ model: Like, complete: @escaping (Result<Like?, Error>) -> Void ) {
        likesEndpoint.delete(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
}
