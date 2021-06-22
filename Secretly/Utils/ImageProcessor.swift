//
//  ImageProcessor.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 21/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit
import CoreImage

struct ImageProcessor {
    let width: CGFloat
    let heigth: CGFloat

    func process(_ image: UIImage, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let resized = resize(image, for: CGSize(width: width, height: heigth)),
                  let result  = blur(resized, radius: 25)
                  else { return }
            DispatchQueue.main.async {
                completion(UIImage(ciImage: result))
            }
        }
    }

    private func resize(_ image: UIImage, for size: CGSize) -> CIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        let resized  = renderer.image { (_) in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
        return CIImage(image: resized)
    }

    private func blur(_ image: CIImage?, radius: CGFloat) -> CIImage? {
        guard let input = image,
              let filter = CIFilter(name: "CIGaussianBlur") else { return nil }
        filter.setValue(input, forKey: kCIInputImageKey)
        filter.setValue(radius, forKey: kCIInputRadiusKey)
        return filter.outputImage
    }
}
