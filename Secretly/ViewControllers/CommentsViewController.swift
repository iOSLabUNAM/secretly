//
//  CommentsViewController.swift
//  Secretly
//
//  Created by Victor Aceves on 28/08/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    var commentService:CommentService? = nil
    var post : Post?
    var callBack: ((_ reloadPosts: Bool)-> Void)?
    var comments:[Comment] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commentService = CommentService(post: post!)
        // set title
        title = "Post Comments"
        setupTable()
        fetchData()
    }
    
    func setupTable() {
        // config tableView
        tableView.rowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(hex: "#E4DDD6")
        tableView.tableFooterView = UIView()
        // cell setup
        tableView.register(UINib(nibName: "RightViewCell", bundle: nil), forCellReuseIdentifier: "RightViewCell")
        tableView.register(UINib(nibName: "LeftViewCell", bundle: nil), forCellReuseIdentifier: "LeftViewCell")
        
    }
    
    func fetchData() {
        commentService?.load { [unowned self] comments in
            self.comments = comments
        }
    }
    
    @IBAction func sendComment(_ sender: UIButton) {
        do{
            try createComment()
        } catch let err {
            self.errorAlert(err)
        }
    }
    
    private func createComment() throws {
        let text:String? = commentTextField.text
        guard let safeText = text else { return }
        let comment = try self.buildComment(comment: safeText)
        guard let safeComment = comment else { return }
        
        commentService?.create(safeComment) { [unowned self] result in
            switch result {
            case .success(let newComment):
                commentTextField.text = ""
                self.showAlert(title: "Comentario publicado", message: newComment?.content ?? "")
                self.fetchData()
                callBack?(true)
            case .failure(let err):
                self.errorAlert(err)
            }
        }
    }
    
    private func buildComment(comment: String) throws -> Comment? {
        if (comment.isBlank || comment.count<4 ) {
            let alert = UIAlertController(title: "Comentario invalido", message: "El comentario no puede estar vacío y debe tener al menos 4 caracteres", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
            return nil
        } else {
            return Comment(content: comment)
        }
    }
    
    func showAlert(title: String, message: String){
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
    }
    
    func errorAlert(_ error: Error) {
        let err = error as? Titleable
        let alert = UIAlertController(title: (err?.title ?? "Ocurrio un error en el servidor"), message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let comment = comments[indexPath.row]
        let isCurrentUser = CurrentUser.load()?.username == comment.author?.name
        if !isCurrentUser {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeftViewCell") as! LeftViewCell
            cell.configureCell(comment: comment)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RightViewCell") as! RightViewCell
            cell.configureCell(comment: comment)
            return cell
        }
    }
}

