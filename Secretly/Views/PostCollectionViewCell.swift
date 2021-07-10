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

    @IBOutlet var authorView: AuthorView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var likeState: UIButton!
    @IBOutlet var commentCounter: UILabel!
    @IBOutlet var likeMsm: UILabel!
    @IBOutlet var likeButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateView() {
        imageView.image = nil
        guard let post = post else { return }
        if let color = UIColor(hex: post.backgroundColor) {
            backgroundColor = color
        }
        contentLabel.text = post.content
        commentCounter.text = String(describing: post.commentsCount ?? 0)
        if let postImg = post.image {
            ImageLoader.load(postImg.mediumUrl) { img in self.imageView.image = img }
        }
        authorView.author = post.user
        likeMsm.text = "\(post.likesCount ?? 0) likes"

        if post.liked ?? false {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

    @IBAction func likeAction(_: Any) {
        likeService?.action { [unowned self] result in
            switch result {
            case .success(nil):
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                post?.unlike()
                self.likeMsm.text = "\(post?.likesCount ?? 0) likes"
            case .success:
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                post?.like()
                self.likeMsm.text = "\(post?.likesCount ?? 0) likes"
            case .failure:
                print("Request fail")
            }
        }
    }

    @IBAction func commentAction(_: Any) {
        print("Comment")
    }
}
