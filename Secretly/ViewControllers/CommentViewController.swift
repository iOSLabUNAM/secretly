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

    var createCommentService:CreateCommentService? = nil
    var fetchCommentService:CommentServie?
    
    @IBOutlet var CommentToolBar: UIToolbar!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var commentTextField: UITextField!
    
    var activeUser:String?
    
    var post:Post? {
        didSet{
            guard let postito = post else { return }
            createCommentService = CreateCommentService(post: postito)
            fetchCommentService = CommentServie(post: postito)
            reloadComments()
        }
    }
    
    func reloadComments(){
        fetchCommentService?.load { [unowned self] comments in
           self.comments = comments
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
    
    private func errorAlert(_ error: Error) {
        let err = error as? Titleable
        let alert = UIAlertController(title: (err?.title ?? "Error Servidor"), message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    /// createComment:
    /// - Throws: The method is sent to be called through the TapAction on the submit button, it throws an exception if the construction of the model fails.
    private func createComment() throws {
        let comment = try self.buildComment()
        guard let commmentM = comment else { return }
        createCommentService?.create(commmentM) { [unowned self] result in
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
            let comment = Comment(content: commentText)
            //comment.autor = CurrentUser.load() as? User
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

extension CommentViewController: UITextFieldDelegate{
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.commentTextField.endEditing(true)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
    }
}


extension CommentViewController{
    func adjustInputText() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                tableView.contentInset = UIEdgeInsets(top: keyboardSize.height - view.safeAreaInsets.top, left: 0, bottom: 0, right: 0)
                self.view.frame.origin.y -= keyboardSize.height - view.safeAreaInsets.bottom
                
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
        }
    }
    
    func showAlert(title: String, message: String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
}
