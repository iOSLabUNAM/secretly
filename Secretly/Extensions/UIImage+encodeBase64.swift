//
//  UIImage+encodeBase64.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 11/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

extension UIImage {
    func encodeBase64() -> String? {
        guard let data = jpegData(compressionQuality: 0.85) else { return nil }
        return "data:image/jpeg;base64,\(data.base64EncodedString())"
    }
}
