//
//  DeleteLikeService.swift
//  Secretly
//
//  Created by Antonio Lara Navarrete on 09/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//
import Foundation

struct DeleteLikeService {
    private var endpoint: RestClient<Like>
    init(id:Int) {
        endpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(id)/likes")
    }

    func delete(_ model: Like, complete: @escaping (Result<Like?, Error>) -> Void ) {
        endpoint.delete(model: model) { result in
            DispatchQueue.main.async { complete(result) }
        }
    }
}
