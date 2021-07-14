//
//  ImageProcessor.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 21/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import CoreImage
import UIKit

struct ImageProcessor {
    let width: CGFloat
    let heigth: CGFloat

    func process(_ image: UIImage, completion: @escaping (UIImage) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let resized = resize(image, for: CGSize(width: width, height: heigth)),
                  let blured = blur(resized, radius: 30)
            else { return }
            DispatchQueue.main.async {
                completion(UIImage(cgImage: blured))
            }
        }
    }

    private func resize(_ image: UIImage, for size: CGSize) -> CIImage? {
        let renderer = UIGraphicsImageRenderer(size: size)
        let resized = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: size))
        }
        return CIImage(image: resized)
    }

    private func blur(_ image: UIImage?, radius: CGFloat) -> CGImage? {
        guard let image = image else { return nil }
        return blur(CIImage(image: image), radius: radius)
    }

    private func blur(_ image: CIImage?, radius: CGFloat) -> CGImage? {
        guard let input = image,
              let filter = CIFilter(name: "CIHexagonalPixellate") else { return nil }
        let context = CIContext()
        filter.setValue(input, forKey: kCIInputImageKey)
        filter.setValue(CIVector(x: width / 2, y: heigth / 2), forKey: kCIInputCenterKey)
        filter.setValue(radius, forKey: kCIInputScaleKey)
        guard let result = filter.outputImage else { return nil }
        return context.createCGImage(result, from: result.extent)
    }
}
