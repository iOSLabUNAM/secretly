//
//  PostCollectionViewCell.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 28/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

// MARK: - Class declaration as View
class PostCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "feedPostCell"
    var likeService: LikeService?
    var post: Post? {
        didSet {
           updateView()
            likeService = LikeService(post: post)
        }
    }
    
// MARK: - Outlets
    @IBOutlet weak var authorView: AuthorView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentCounter: UILabel!
    @IBOutlet weak var likesMessage: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
// MARK: - Override
    override func awakeFromNib() {
        super.awakeFromNib()
    }

// MARK: - Methods
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
        self.likesMessage.text = "\(post.likesCount!) likes"
    
        if post.liked ?? false {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
// MARK: - Actions
    @IBAction func likeAction(_ sender: Any) {
        likeService?.action() { [unowned self] result in
                    switch result {
                    case .success(nil):
                        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                        let newLikesCount = post?.likesCount ?? 0
                        self.likesMessage.text = "\(newLikesCount - 1) likes"
                    case .success( _):
                        likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                        let newLikesCount = post?.likesCount ?? 0
                        self.likesMessage.text = "\(newLikesCount + 1) likes"
                    case .failure(_):
                        print("Request fail")
                    }
                }
    }
    
}
