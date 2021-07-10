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
    var post: Post? {
        didSet {
           updateView()
           likeService = LikeService(post: post)
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
    }

    func updateView() {
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
    
    @objc private func tapLike(){
        guard let post = post, let id = post.id else {return}
        let updateLike = Like(id: id, createdAt: Date(), updatedAt: Date())
        if !post.liked {
            likeService?.create(updateLike) { result in
                self.likeState.image = UIImage(systemName: "heart.fill")
                self.likeCounter.text = String(describing: post.likesCount! + 1)
            }
        } else {
            likeService?.delete(updateLike) { result in
                self.likeState.image = UIImage(systemName: "heart")
                self.likeCounter.text = String(describing: post.likesCount! - 1)
            }
        }
    }
    
}
