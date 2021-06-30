//
//  PostInputViewController+UIImagePickerControllerDelegate.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 19/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit
import AVFoundation

extension PostInputViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let img = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ImageProcessor(width: 512, heigth: 512).process(img) {
                do {
                    try NudityChecker().validate(img)
                    self.previewPost.image = $0
                    self.previewPost.backgroundColor = .black
                } catch let err {
                    self.errorAlert(err)
                }
            }
            picker.dismiss(animated: true)
        }
    }
}
