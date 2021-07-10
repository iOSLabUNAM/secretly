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
    var likeService: LikeService?
    var updatePostService: UpdatePostService?
    var post: Post? {
        didSet {
           updateView()
           likeService = LikeService(post: post)
           updatePostService = UpdatePostService(post: post)
        }
    }
    @IBOutlet weak var authorView: AuthorView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeState: UIImageView!
    @IBOutlet weak var commentCounter: UILabel!
    @IBOutlet weak var likeCounter: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapLikeState = UITapGestureRecognizer(target: self, action: #selector(tapLike))
        self.likeState.isUserInteractionEnabled = true
        self.likeState.addGestureRecognizer(tapLikeState)
        
        let doubleTapImageView = UITapGestureRecognizer(target: self, action: #selector(doubleTapImageViewLike))
        doubleTapImageView.numberOfTapsRequired = 2
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(doubleTapImageView)
    }

    func updateView() {
        status()
        imageView.image = nil
        guard let post = post else { return }
        if let color = UIColor(hex: post.backgroundColor) {
            self.backgroundColor = color
        }
        self.contentLabel.text = post.content
        self.commentCounter.text = String(describing: post.commentsCount ?? 0)
        self.likeCounter.text = String(describing: post.likesCount ?? 0)
        if let postImg = post.image {
            ImageLoader.load(postImg.mediumUrl) { img in self.imageView.image = img }
        }
        self.authorView.author = post.user
    }
    
    func status() {
        guard let post = post else {return}
        if post.liked {
            likeState.image = UIImage(systemName: "heart.fill")
        } else {
            likeState.image = UIImage(systemName: "heart")
        }
    }
    
    @objc private func tapLike(){
        self.like()
    }
    
    @objc private func doubleTapImageViewLike(_ gesture: UITapGestureRecognizer){
        self.like()
    }
    
    private func like(){
        guard let post = post, let id = post.id else {return}
        let updateLike = Like(id: id, createdAt: Date(), updatedAt: Date())
        if !post.liked {
            likeService?.create(updateLike) { result in
                self.updatePost(id: id, sum: 1, state: true)
                self.likeState.image = UIImage(systemName: "heart.fill")
                self.likeCounter.text = String(describing: post.likesCount! + 1)
            }
        } else {
            likeService?.delete(updateLike) { result in
                self.updatePost(id: id, sum: -1, state: false)
                self.likeState.image = UIImage(systemName: "heart")
                self.likeCounter.text = String(describing: post.likesCount! - 1)
            }
        }
    }
    
    func updatePost(id: Int, sum: Int, state: Bool) {
        guard let post = post else {return}
        var newPost = post
        newPost.likesCount = post.likesCount ?? 0 + sum
        newPost.liked = state
        updatePostService?.update(newPost) { result in
            switch result {
            case .success:
                print("Success update \(result)")
            case .failure:
                print("Failure update \(result)")
            }
        }
    }
    
}
