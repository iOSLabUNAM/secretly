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
    var likeDelegate : LikeInputDelegate?
    var post: Post? {
        didSet {
           updateView()
        }
    }
    @IBOutlet weak var authorView: AuthorView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeState: UIImageView!
    @IBOutlet weak var commentCounter: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeStateTapped))
        likeState.isUserInteractionEnabled = true
        likeState.addGestureRecognizer(tap)
    }

    func updateView() {
            imageView.image = nil
            guard let post = post else { return }
            if let color = UIColor(hex: post.backgroundColor) {
                self.backgroundColor = color
            }
            
            if let liked = post.liked{
                self.changeLikeState(liked: liked)
            }
            
            self.contentLabel.text = post.content
            self.commentCounter.text = String(describing: post.commentsCount ?? 0)
            if let postImg = post.image {
                ImageLoader.load(postImg.mediumUrl) { img in self.imageView.image = img }
            }
            self.authorView.author = post.user
            
            
        }
    
    @objc func likeStateTapped(tapGestureRecognizer: UITapGestureRecognizer){
        print("tocando")
        guard let delegate = likeDelegate else {return}
        guard let liked = self.post?.liked else {return}
        guard let postId = self.post?.id else {return}
        if !liked {
            delegate.likeToPost(postId: postId)
        } else {
            delegate.dislikeToPost(postId: postId)
        }
    }
    
    func changeLikeState(liked:Bool){
        if liked {
            likeState.image = UIImage(systemName:"heart.fill")
            likeState.tintColor = .red
        } else {
            likeState.image = UIImage(systemName:"heart")
            likeState.tintColor = .white
        }
    }

}















