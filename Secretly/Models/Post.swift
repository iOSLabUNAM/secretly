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
    var imageData: String?
    let user: User?
    let commentsCount: Int?
    let latitude: Double?
    let longitude: Double?
    let createdAt: Date?
    let updatedAt: Date?
    var likesCount: Int?
    var liked: Bool?

    init(content: String, backgroundColor: String, latitude: Double? = nil, longitude: Double? = nil, image: UIImage? = nil) {
        self.content = content
        self.backgroundColor = backgroundColor
        id = nil
        self.image = nil
        imageData = image?.encodeBase64()
        self.latitude = latitude
        self.longitude = longitude
        user = nil
        commentsCount = nil
        createdAt = nil
        updatedAt = nil
        likesCount = nil
        liked = nil
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(content, forKey: .content)
        try container.encode(backgroundColor, forKey: .backgroundColor)
        try container.encode(imageData, forKey: .imageData)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }

    mutating func like() {
        likesCount = (likesCount ?? 0) + 1
        liked = true
    }

    mutating func unlike() {
        likesCount = (likesCount ?? 0) - 1
        liked = false
    }
}
