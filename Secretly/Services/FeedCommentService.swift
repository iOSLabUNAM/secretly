//
//  FeedCommentService.swift
//  Secretly
//
//  Created by Fernanda Hernandez on 01/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
struct FeedCommentService {
    private var feedCommenTEndpoint: RestClient<Comment>?

 
    
    init(post: Post?){
            guard let post = post, let postId = post.id else {return}
            self.feedCommenTEndpoint = RestClient<Comment>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(postId)/comments")
           
        }

    func load(completion: @escaping ([Comment]) -> Void) {
        feedCommenTEndpoint?.list { result in
            guard let comments = try? result.get() else { return }
            DispatchQueue.main.async { completion(comments) }
        }
    }
    
}

