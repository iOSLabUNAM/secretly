//
//  CacheImage.swift
//  Secretly
//
//  Created by LuisE on 22/10/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

class CacheImage {
    static let shared = CacheImage()
    private var memCache = NSCache<NSString, UIImage>()

    func read(key: String) -> UIImage? {
        return memCache.object(forKey: key as NSString)
    }

    func write(key: String, value: UIImage?) {
        guard let value = value else { return }
        memCache.setObject(value, forKey: key as NSString)
    }
}
