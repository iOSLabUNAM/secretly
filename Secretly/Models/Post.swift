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
//    New
    var likesCount: Int?
    var liked: Bool?

    init(content: String, backgroundColor: String, latitude: Double? = nil, longitude: Double? = nil, image: UIImage? = nil) {
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
//        New
        self.likesCount = nil
        self.liked = nil
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(content, forKey: .content)
        try container.encode(backgroundColor, forKey: .backgroundColor)
        try container.encode(imageData, forKey: .imageData)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
//        New
        try container.encode(liked, forKey: .liked)
        try container.encode(likesCount, forKey: .likesCount)
    }
//    New function to Like
    mutating func newLike(state:String){
         if state == "inc"{
             likesCount = (likesCount ?? 0) + 1
             liked = true
         } else if state == "dec"{
             likesCount = (likesCount ?? 0) - 1
             liked = false
         }
    }
}
