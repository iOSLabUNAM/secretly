//
//  ImageStore.swift
//  Secretly
//
//  Created by LuisE on 22/10/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

// Usage
// ImagaStore.permanent.write("filename.jpg", image: img)
// ImagaStore.cache.read("filename.jpg")

enum ImageStore {
    case cache
    case permanent

    var container: DataContainer {
        switch self {
        case .cache:
            return DataContainer.cache
        case .permanent:
            return DataContainer.permanent
        }
    }

    func read(_ filename: String) -> UIImage? {
        if let img = CacheImage.shared.read(key: filename) {
            return img
        }
        guard let data = container.read(filename) else { return nil }
        let image = UIImage(data: data)

        CacheImage.shared.write(key: filename, value: image)
        return image
    }

    func write(_ filename: String, image: UIImage) -> Bool {
        guard let data = image.jpegData(compressionQuality: 0.9) else { return false }

        CacheImage.shared.write(key: filename, value: image)
        return container.write(filename, data: data)
    }
}
