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
//            self.previewPost.image = img
            ImageProcessor(width: 512, heigth: 512).process(img) { self.previewPost.image = $0 }
            picker.dismiss(animated: true)
        }
    }
}
