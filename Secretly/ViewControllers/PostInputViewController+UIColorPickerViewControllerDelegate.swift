//
//  PostInputViewController+UIColorPickerViewControllerDelegate.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 19/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

extension PostInputViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        previewPost.backgroundColor = viewController.selectedColor.pastel()
    }
}
