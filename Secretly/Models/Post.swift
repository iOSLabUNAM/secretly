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
    var isLiked: Bool?
    
    init(content: String, backgroundColor: String, latitude: Double? = nil, longitude: Double? = nil, image: UIImage? = nil, likesCount: Int? = nil, isLiked: Bool? = nil) {
        self.content = content
        self.backgroundColor = backgroundColor
        self.id = nil
        self.image = nil
        self.imageData = image?.encodeBase64()
        self.latitude = latitude
        self.longitude = longitude
        self.user = nil
        self.commentsCount = nil
        self.createdAt = nil
        self.updatedAt = nil
        self.likesCount = likesCount
        self.isLiked = isLiked
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(content, forKey: .content)
        try container.encode(backgroundColor, forKey: .backgroundColor)
        try container.encode(imageData, forKey: .imageData)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    mutating func toggleLike(isLiked:Bool){
        likesCount = isLiked ? (likesCount ?? 0) + 1 : (likesCount ?? 0) - 1
        self.isLiked = isLiked
    }
    
}
