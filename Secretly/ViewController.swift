//
//  ViewController.swift
//  Secretly
//
//  Created by LuisE on 2/16/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var helloLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        CurrentUserService().auth { [unowned self] currentUser in
            self.helloLbl.text = "Hello \(currentUser.username)"
            self.performSegue(withIdentifier: "showFeedSegue", sender: self)
        }
    }
}
