//
//  CommentService.swift
//  Secretly
//
//  Created by Samuel Arturo Garrido Sánchez on 2021-07-02.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct CommentService {
    private var endpoint: RestClient<Comment>
    private var post: Post?

    init(post: Post) {
        endpoint = RestClient<Comment>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(post.id ?? 1)/comments")
        self.post = post
    }

    func create(_ model: Comment, complete: @escaping (Result<Comment?, Error>) -> Void ) {
        try? endpoint.create(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
    
    func delete(_ model: Comment, complete: @escaping (Result<Comment?, Error>) -> Void ) {
        let deleteEndpoint = RestClient<Comment>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(post?.id ?? 1)/comments/\(model.id ?? -1)")
        print(deleteEndpoint.path)
        print(model)
        deleteEndpoint.delete(model: model, complete: { result in
            DispatchQueue.main.async {
                complete(result)
            }
        })
    }
    
    func update(_ model: Comment, complete: @escaping (Result<Comment?, Error>) -> Void ) {
        let updateEndpoint = RestClient<Comment>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(post?.id ?? 1)/comments/\(model.id ?? -1)")
        print(updateEndpoint.path)
        
        try? updateEndpoint.update(model: model){ result in
            DispatchQueue.main.async {
                complete(result)
            }
        }
    }
    
    
    
    func load(completion: @escaping ([Comment]) -> Void) {
        endpoint.list { result in
            guard let posts = try? result.get() else { return }
            DispatchQueue.main.async { completion(posts) }
        }
    }
    
    static func count(post:Post,completion: @escaping ([Comment]) -> Void){
        let endPoint = RestClient<Comment>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(post.id ?? 1)/comments")
        endPoint.list { result in
            guard let posts = try? result.get() else { return }
            DispatchQueue.main.async {
                completion(posts)
            }
        }
    }
}
