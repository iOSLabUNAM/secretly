//
//  UserProfileViewController.swift
//  Secretly
//
//  Created by Yocelin Garcia Romero on 13/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    let service = UserProfileService()

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
}
