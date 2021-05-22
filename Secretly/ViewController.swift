//
//  ViewController.swift
//  Secretly
//
//  Created by LuisE on 2/16/20.
//  Copyright © 2020 3zcurdia. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    @IBOutlet weak var helloLbl: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        AF.request("https://secretlyapi.herokuapp.com/api/v1/fake").responseDecodable(of: Faker.self) { [unowned self] response in
            let fake = try? response.result.get()
            DispatchQueue.main.async {
                self.helloLbl.text = "Hello \(fake?.username ?? "Joe.Doe")!"
            }
        }
    }
}
