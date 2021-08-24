//
//  ProfileViewController.swift
//  Secretly
//
//  Created by Maria Lacayo on 23/08/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var commentsCounter: UILabel!
    @IBOutlet weak var likesCounter: NSLayoutConstraint!
    
    var profile = ProfileService()
    override func viewDidLoad() {
        profile.setProfile { profile in
            print(profile)
            self.userName.text = profile.username
            ImageLoader.load(profile.avatarUrl) { [unowned self] image in self.userImage.image = image }
        }
    }
}
