//
//  UserProfileViewController.swift
//  Secretly
//
//  Created by Yocelin Garcia Romero on 13/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userProfileName: UILabel!
    
    let service = UserProfileService()
    var user: User? {
        didSet {
            setUserView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "background-green")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        loadUserProgile()
    }
    
    @objc
    func loadUserProgile() {
        service.showProfile { [unowned self] user in self.user = user }
    }
    
    @objc func setUserView(){
        userProfileImage.image = nil
        
        guard let user = user else { return }
        
        userProfileName.text = user.username
        ImageLoader.load(user.avatarUrl) { [unowned self] img in self.userProfileImage.image = img }
    }
}
