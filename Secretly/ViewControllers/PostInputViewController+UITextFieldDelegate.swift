//
//  PostInputViewController+UITextFieldDelegate.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 19/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

extension PostInputViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn _: NSRange, replacementString _: String) -> Bool {
        previewPost.content = textField.text
        return true
    }
}
