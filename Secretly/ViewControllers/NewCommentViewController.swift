//
//  NewCommentViewController.swift
//  Secretly
//
//  Created by Fernanda Hernandez on 30/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

class NewCommentViewController: UIViewController {
    
    let refreshControl = UIRefreshControl()
    
    var postSelected: Post? {
        didSet {
            loadComments()
        }
    }
    var comments: [Comment]?{
        didSet {
            self.commentCollection?.reloadData()
           self.refreshControl.endRefreshing()
        }
    }

    @IBOutlet weak var commentContent: UITextField!
    @IBOutlet weak var commentCollection: UICollectionView!
    
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)

        comments = []
    }
    @IBAction func onTapCreateComment(_ sender: Any) {
        do {
            if(commentContent.text == ""){
                showAlert()
            }
            else{
                try self.createComment()
                self.commentCollection.reloadData()
                commentContent.text = ""
               
                if(comments!.count <= 4){
                    dismiss(animated: true, completion: nil)
                    
                }
                else{
                    showAlertOk()
                }
            }
            
        } catch let err {
            self.errorAlert(err)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSetUp()
    }
    
     func loadSetUp(){
        self.commentCollection.reloadData()
        let nib = UINib(nibName: String(describing: CommentCollectionViewCell.self), bundle: nil)
        commentCollection.register(nib, forCellWithReuseIdentifier: CommentCollectionViewCell.reuseIdentifier)
        commentCollection.delegate = self
        commentCollection.dataSource = self
        commentCollection.prefetchDataSource = self
        commentCollection.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(self.loadComments), for: UIControl.Event.valueChanged)
        
    }
    private func buildComment() throws -> Comment {
        guard let postText = commentContent.text else {
            throw EmptyPostError()
        }
        var post = Comment(
            content: postText
        )

        return post
    }
    private func errorAlert(_ error: Error) {
        let err = error as? Titleable
        let alert = UIAlertController(title: (err?.title ?? "Server Error"), message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    private func createComment() throws {
        let id = 0
        let commentService = CreatCommentsService(id: (postSelected?.id!)!)
        let comment = try self.buildComment()
        commentService.create(comment) { [unowned self] result in
            switch result {
            case .success(let comment):
                print("se subió chido")
            case .failure(let err):
                self.errorAlert(err)
                showAlert()
            }
        }
    }
    
    func showAlert(){
        let alert = UIAlertController(title: "", message: "Comentario vacío", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: {_ in
            print("")
        }))
        present(alert, animated: true)
    }
    func showAlertOk(){
        let alert = UIAlertController(title: "", message: "Comentario subido exitosamente", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .cancel, handler: {_ in
            print("puchurraste cancelar")
        }))
        present(alert, animated: true)
    }
    
    @objc
    func loadComments() {
        var feedCommentService = FeedCommentService(post: postSelected!)
        feedCommentService.load { [unowned self] comments in self.comments = comments }
    }
}

extension NewCommentViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommentCollectionViewCell.reuseIdentifier, for: indexPath) as! CommentCollectionViewCell
        cell.comment = self.comments?[indexPath.row]
        return cell
    }
    
}

extension NewCommentViewController: UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let indexPath = indexPaths.last else { return }
        print("================\(indexPath.row)=================")
    }
}
extension NewCommentViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 150)
    }
}
