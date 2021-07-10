//
//  File.swift
//  Secretly
//
//  Created by Proteco on 10/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct UpdatePostService {
    private var endpoint: RestClient<Post>?
    
    init(post: Post?) {
        guard let postId = post?.id else {
            self.endpoint = nil
            return
        }
        self.endpoint = RestClient<Post>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(postId)")
    }
    
    func update(_ model: Post, complete: @escaping (Result<Post?, Error>) -> Void) {
        try? endpoint?.update(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
    
}
