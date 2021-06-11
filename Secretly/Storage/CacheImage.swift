//
//  CacheImage.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 29/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

class CacheImage {
    static let shared = CacheImage()
    private var memCache = NSCache<NSString, UIImage>()

    func read(key: String) -> UIImage? {
        return memCache.object(forKey: key as NSString)
    }

    func write(key: String, image: UIImage?) {
        guard let image = image else { return }
        memCache.setObject(image, forKey: key as NSString)
    }
}
