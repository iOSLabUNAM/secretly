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
    var like :Like?{
        didSet{
            updateView()
        }
    }
    
    @IBOutlet weak var bigLikeState: UIImageView!
    @IBOutlet weak var authorView: AuthorView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeState: UIImageView!
    @IBOutlet weak var commentCounter: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap=UITapGestureRecognizer(target: self, action: #selector(tapLike(_:)))
        imageView.isUserInteractionEnabled=true
        imageView.addGestureRecognizer(tap)
        
    }
    @objc func tapLike(_ sender: UITapGestureRecognizer){
        guard let post=post, let id=post.id else{return}
        let updateLike=Like(id: id, createdAt: Date(), updatedAt: Date())
        
        if post.liked {
            print("Tiene like")
//            Eliminar like
            let delLike=DeleteLikeService(id:id)
            delLike.delete(updateLike) { resultDelLike in
                switch resultDelLike {
                case .success:
                    print("Like borrado")
                    self.updatePost(id: id, sum: -1,state: false)
                case .failure:
                    print("Like NO borrado")
                }
            }
            
        }else {
            print("No tiene like")
            let createLike=CreateLikeService(id: id)
            createLike.create(updateLike) { resultDelLike in
                switch resultDelLike {
                case .success:
                    print("Like creado")
                    self.updatePost(id: id, sum: 1,state: true)
                case .failure:
                    print("Like NO creado")
                }
            }
            
        }
    }
    func updatePost(id:Int,sum:Int,state:Bool) {
        guard let post = post, let id=post.id else{return}
        let updatePost=UpdatePostService(id: id)
        var newPost=post
        newPost.liked=state
        newPost.likesCount=post.likesCount+sum
        
        updatePost.update(newPost) { resultUpdatePost in
            switch resultUpdatePost {
            case .success:
                print("Post updated")
                
            case .failure:
                print("Post not updated")
            }
        }
    }

    func updateView() {
        imageView.image = nil
        guard let post = post else { return }
        if let color = UIColor(hex: post.backgroundColor) {
            self.backgroundColor = color
        }
        checkStatus()
        self.contentLabel.text = post.content
        self.commentCounter.text = String(describing: post.commentsCount ?? 0)
        if let postImg = post.image {
            ImageLoader.load(postImg.mediumUrl) { img in self.imageView.image = img }
        }
        self.authorView.author = post.user
    }
    func checkStatus(){
        guard let post=post else{return}
        if post.liked{
            likeState.tintColor = .red
            bigLikeState.isHidden = false
        }else {
            likeState.tintColor = .white
            bigLikeState.isHidden = true
        }
        
        likeLabel.text = String(describing: post.likesCount)
    }
}
