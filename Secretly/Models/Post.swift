//
//  Post.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 28/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

struct Post: Restable {
    var id: Int?
    let content: String
    let backgroundColor: String
    let image: Image?
    let imageData: String?
    let user: User?
    let commentsCount: Int?
    let createdAt: Date?
    let updatedAt: Date?

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(content, forKey: .content)
        try container.encode(backgroundColor, forKey: .backgroundColor)
        try container.encode(imageData, forKey: .imageData)
    }
}
