//
//  CreatePostViewController.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 05/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {
    @IBOutlet var contentField: UITextField!
    @IBOutlet var colorField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        colorField.text = "#3366CC"
    }

    @IBAction
    func createPost(_: Any?) {
        let post = Post(content: contentField.text!, backgroundColor: colorField.text!)
        let postsEndpoint = RestClient<Post>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts")

        do {
            try postsEndpoint.create(model: post) { [unowned self] result in
                switch result {
                case let .success(post):
                    print("there is a new post \(post?.id ?? 0)")
                case let .failure(err):
                    DispatchQueue.main.async {
                        self.errorAlert(err)
                    }
                }
            }
        } catch let err {
            self.errorAlert(err)
        }
    }

    func errorAlert(_ error: Error) {
        let err = error as? Titleable
        let alert = UIAlertController(title: err?.title ?? "Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
