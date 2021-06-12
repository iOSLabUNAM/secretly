//
//  Post.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 28/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

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

    init(content: String, backgroundColor: String, image: UIImage? = nil) {
        self.content = content
        self.backgroundColor = backgroundColor
        self.id = nil
        self.image = nil
        self.imageData = image?.encodeBase64()
        self.user = nil
        self.commentsCount = nil
        self.createdAt = nil
        self.updatedAt = nil
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(content, forKey: .content)
        try container.encode(backgroundColor, forKey: .backgroundColor)
        try container.encode(imageData, forKey: .imageData)
    }
}
