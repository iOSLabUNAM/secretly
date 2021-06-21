//
//  ImageStore.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 29/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

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
        if let img = CacheImage.shared.read(key: filename) { return img }
        guard let data = container.read(filename) else {
            return nil
        }
        return UIImage(data: data)
    }

    func write(_ filename: String, image: UIImage) -> Bool {
        guard let data = image.pngData() else { return false }
        CacheImage.shared.write(key: filename, image: image)
        return container.write(filename, data: data)
    }
}
