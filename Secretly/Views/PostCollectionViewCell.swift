//
//  PostCollectionViewCell.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 28/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "feedPostCell"
    var post: Post? {
        didSet {
           updateView()
        }
    }
    @IBOutlet weak var authorView: AuthorView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeState: UIButton!
    @IBOutlet weak var commentCounter: UILabel!
    @IBOutlet weak var likeMsm: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateView() {
        imageView.image = nil
        guard let post = post else { return }
        if let color = UIColor(hex: post.backgroundColor) {
            self.backgroundColor = color
        }
        self.contentLabel.text = post.content
        self.commentCounter.text = String(describing: post.commentsCount ?? 0)
        if let postImg = post.image {
            ImageLoader.load(postImg.mediumUrl) { img in self.imageView.image = img }
        }
        self.authorView.author = post.user
        self.likeMsm.text = getLikeMessage(post: post)
        self.likeState.isEnabled = setLikeState(post: post)
    }
    
    func setLikeState(post: Post) -> Bool {
        let userName = post.user?.username ?? ""
        let likeAuthors = post.likes ?? []
        
        let userLikedItsPhoto = likeAuthors.filter({$0.author?.name == userName})
        
        var buttonStatus = true
        if(userLikedItsPhoto.count == 1){
            buttonStatus = false
        }
        
        return buttonStatus
    }
    
    func getLikeMessage(post: Post) -> String {
        let likeCount = post.likes?.count ?? 0
        let likeAuthors = post.likes
        
        var authorsResume = ""
        
        if(likeCount == 1) {
            authorsResume = "\(likeAuthors?[0].author?.name ?? "") has liked this photo"
        }
        
        if(likeCount >= 2){
            let nameOne = likeAuthors?[0].author?.name ?? ""
            let nameTwo = likeAuthors?[1].author?.name ?? ""
            authorsResume = "\(nameOne), \(nameTwo) and \(likeCount) more, liked this photo"
        }
        
        return authorsResume
    }
    
    func like(){
        let likeEndpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(String(describing: post?.id))/likes")

        do {
            try likeEndpoint.create() { [unowned self] result in
                switch result {
                case .success(let like):
                    print("there is a new like \(like?.author?.name ?? "")")
                case .failure(let err):
                    DispatchQueue.main.async {
                        self.errorAlert(err)
                    }
                }
            }
        } catch let err {
            self.errorAlert(err)
        }
    }
    
    func unlike(){
        let likeEndpoint = RestClient<Like>(client: AmacaConfig.shared.httpClient, path: "/api/v1/posts/\(String(describing: post?.id))/likes")

        do {
            try likeEndpoint.delete() { [unowned self] result in
                switch result {
                case .success( _):
                    print("Like deleted")
                case .failure(let err):
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
        let alert = UIAlertController(title: (err?.title ?? "Server Error"), message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
    }
    
    @IBAction func likeAction(_ sender: Any) {
        print("like: \(self.likeState.isEnabled)")
        if self.likeState.isEnabled == true {
            //like()
            self.likeState.isEnabled = false
            
        } else {
            //unlike()
            self.likeState.isEnabled = true
        }
    }
    
    
    @IBAction func commentAction(_ sender: Any) {
        print("Comment")
    }
}
