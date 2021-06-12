//
//  String+isBlank.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 11/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

extension String {
    var isBlank: Bool {
        return self.isEmpty || self.trimmingCharacters(in: .whitespaces) == ""
    }
}
