//
//  ComentService.swift
//  Secretly
//
//  Created by Fernanda Hernandez on 25/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct CreatCommentsService {
    private var commentEndpoint: RestClient<Comment>
    
    init(id: Int) {
        
        if(id == 0){
            print("a ver que pasa")
        }
        commentEndpoint = RestClient<Comment>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(id)/comments")
    }
    func create(_ model: Comment, complete: @escaping (Result<Comment?, Error>) -> Void ) {
        try? commentEndpoint.create(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
    
}
