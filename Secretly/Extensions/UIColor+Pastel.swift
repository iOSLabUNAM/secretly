//
//  UIColor+Pastel.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 11/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

extension UIColor {
    func pastel() -> UIColor {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        return UIColor(hue: hue, saturation: CGFloat(0.70), brightness: brightness, alpha: alpha)
    }
}
