//
//  NudityChecker.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 30/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

struct NSFWContentError: Error, Titleable {
    var title: String { "The image contains nudity" }

    var localizedDescription: String { "The image has a \(prob)% of NSFW contnet." }

    let prob: Double

    init(_ prob: Double?) {
        self.prob = (prob ?? 0.0) * 100.0
    }
}

struct NudityChecker {
    let model = Nudity()
    private let size = CGSize(width: 224, height: 224)

    func validate(_ image: UIImage) throws {
        guard let buffer = image.resize(to: size)?.pixelBuffer() else { return }

        let result = try model.prediction(data: buffer)
        #if DEBUG
            debugPrint(result.classLabel)
            debugPrint(result.prob)
        #endif

        if result.classLabel == "NSFW" || (result.prob["NSFW"] ?? 0) > 0.55 {
            throw NSFWContentError(result.prob["NSFW"])
        }
    }
}
