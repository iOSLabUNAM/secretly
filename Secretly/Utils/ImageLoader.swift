//
//  ImageLoader.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 29/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

struct ImageLoader {
    static func load(_ stringUrl: String, completion: @escaping (UIImage) -> Void) {
        let filename = Checksum.sha256(stringUrl)
        if let img = ImageStore.cache.read(filename) {
            completion(img)
            return
        }

        guard let url = URL(string: stringUrl) else { return }
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url), let img = UIImage(data: data) {
                DispatchQueue.main.async { completion(img) }
                _ = ImageStore.cache.write(filename, image: img)
            }
        }
    }
}
