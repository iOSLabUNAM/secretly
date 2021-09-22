//
//  UIView+Rounded.swift
//  Secretly
//
//  Created by Victor Aceves on 22/09/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

extension UIView{
    func rounded(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

