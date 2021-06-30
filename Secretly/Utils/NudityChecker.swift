//
//  NudityChecker.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 30/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

struct NSFWContentError: Error, Titleable {
    var title: String {
        get { "The image contains nudity" }
    }
}

struct NudityChecker {
    let model = Nudity()
    private let size = CGSize(width: 224, height: 224)

    func validate(_ image: UIImage?) throws {
        guard let image = image else { return }

        guard let buffer = image.resize(to: size)?.pixelBuffer() else { return }

        let result = try model.prediction(data: buffer)

        if result.classLabel == "NSFW" && (result.prob["NSFW"] ?? 0) > 0.6 {
            throw NSFWContentError()
        }
    }
}
