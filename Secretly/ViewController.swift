//
//  ViewController.swift
//  Secretly
//
//  Created by LuisE on 2/16/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import UIKit

struct Faker: Codable {
    let email: String
    let username: String
}

class ViewController: UIViewController {
    @IBOutlet weak var helloLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let endpoint = Endpoint<Faker>(client: Client.api, path: "/api/v1/fake" )
        endpoint.find { result in
            switch result {
            case .success(let fake):
                self.helloLbl.text = "Hello \(fake?.username ?? "Joe.Doe")!"
            case .failure(let err):
                debugPrint("oups!: \(err)")
            }
        }
    }
}
