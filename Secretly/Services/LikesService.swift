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
    
    init(post: Post?) {
        self.endpoint = RestClient<Likes>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(post?.id ?? 1)/likes")
    }
    
    func like(_ model: Likes, complete: @escaping (Result<Likes?, Error>) -> Void ) {
        try? endpoint.create(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
    
    func unlike(_ model: Likes, complete: @escaping (Result<Likes?, Error>) -> Void) {
        endpoint.delete(model: model) { result in
                DispatchQueue.main.async { complete(result) }
            }
        }
    
}
