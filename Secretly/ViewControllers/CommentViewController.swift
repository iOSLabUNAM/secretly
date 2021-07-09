//
//  CommentViewController.swift
//  Secretly
//
//  Created by Samuel Arturo Garrido Sánchez on 2021-07-02.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

// MARK: TODO:
/*  - Better organize methods in extensions
    - Activity indicator, extension to VC, program fetch times
    - Get CurrentUser to User(username,avatarUrl)
*/
class CommentViewController: UIViewController{

    var commentService:CommentService? = nil
    var currentUserService:CurrentUserService? = nil
    let fakeEndpoint = RestClient<Faker>(client: AmacaConfig.shared.httpClient, path: "/api/v1/fake")
    
    @IBOutlet var CommentToolBar: UIToolbar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var commentTextField: UITextField!
    
    var activeUser:String?
    
    var post:Post? {
        didSet{
            guard let postito = post else { return }
            commentService = CommentService(post: postito)
            reloadComments()
        }
    }
    
    func reloadComments(){
        commentService?.load { [unowned self] comments in
           self.comments = comments
            comments.forEach({ comn in
                print(comn.autor)
            })
        }
    }
    
    public func clear() {
        commentTextField?.text = ""
    }
    
    var comments:[Comment]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adjustInputText()
        tableView.delegate = self
        tableView.dataSource = self
        commentTextField.delegate = self
    }
    
    
    @IBAction func didTapSendComment(_ sender: Any) {
        do {
            try self.createComment()
        } catch let err {
            self.errorAlert(err)
        }
        self.commentTextField.endEditing(true)
    }
    
    func errorAlert(_ error: Error) {
        let err = error as? Titleable
        let alert = UIAlertController(title: (err?.title ?? "Error Servidor"), message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func createComment() throws {
        let comment = try self.buildComment()
        guard let commmentM = comment else { return }
        
        commentService?.create(commmentM) { [unowned self] result in
            switch result {
            case .success(let commmentM):
                self.showAlert(title: "Comentario publicado", message: commmentM?.content ?? "")
                self.reloadComments()
            case .failure(let err):
                self.errorAlert(err)
            }
        }
    }
    
    private func buildComment() throws -> Comment? {
        if let commentText = commentTextField.text{
            print(CurrentUser.load()?.username ?? "No hay current user")
            var comment = Comment(content: commentText)
            let autor = User(username: CurrentUser.load()?.username ?? "", avatarUrl: "")
            comment.autor = autor
            return comment
        } else{
            let alert = UIAlertController(title: "Sin comentarios", message: "Llena por favor el comentario", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return nil
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: self.view.window)
    }
}

