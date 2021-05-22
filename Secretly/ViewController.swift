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

    let client = HttpClient(session: URLSession.shared, baseUrl: "https://secretlyapi.herokuapp.com")

    lazy var fakeEndpoint: RestClient<Faker> = {
        return RestClient<Faker>(client: client, path: "/api/v1/fake")
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        fakeEndpoint.show { [unowned self] result in
            let fake = try? result.get()
            DispatchQueue.main.async {
                self.helloLbl.text = "Hello \(fake?.username ?? "Joe.Doe")!"
            }
        }
    }
}
