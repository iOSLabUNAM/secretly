//
//  PostCollectionViewCell.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 28/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
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
    @IBOutlet weak var likesCounter: UILabel!
    @IBOutlet weak var commentCounter: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapLike = UITapGestureRecognizer(target: self, action: #selector(handleLike))
        self.likeState.addGestureRecognizer(tapLike)
        
        let doubleTapImage = UITapGestureRecognizer(target: self, action: #selector(handleLike))
        doubleTapImage.numberOfTapsRequired = 2
        self.imageView.addGestureRecognizer(doubleTapImage)
    }
    
    // MARK: - Actions
    @objc func handleLike() {
        post?.liked?.toggle()
        guard let postLiked = post?.liked, let postLikesCount = post?.likesCount else { return }
        if postLiked {
            self.likeService?.likePost { [weak self] _ in
                guard let self = self else { return }
                if postLikesCount > 0 {
                    self.post?.likesCount! += 1
                }
                self.setupLike()
            }
        } else {
            self.likeService?.dislikePost { [weak self] _ in
                guard let self = self else { return }
                self.post?.likesCount! -= 1
                self.setupLike()
            }
        }
        
    }

    // MARK: - Helper functions
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
        setupLike()
    }
    
    private func setupLike() {
        let imageName = post?.liked ?? false ? "heart.fill" : "heart"
        likeState.image = UIImage(systemName: imageName)
        if post?.likesCount == 1 {
            likesCounter.text = "\(post?.likesCount ?? 1) like"
        } else {
            likesCounter.text = "\(post?.likesCount ?? 0) likes"
        }
    }
}
