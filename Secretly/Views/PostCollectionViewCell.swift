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
        self.likeMsm.text = "\(post.likesCount ?? 0) likes"
        
        if post.liked ?? false {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func likeAction(_ sender: Any) {
        likeService?.action() { [unowned self] result in
            switch result {
            case .success(nil):
                likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                post?.unlike()
                self.likeMsm.text = "\(post?.likesCount ?? 0) likes"
            case .success( _):
                likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                post?.like()
                self.likeMsm.text = "\(post?.likesCount ?? 0) likes"
            case .failure(_):
                print("Request fail")
            }
        }
    }
    
    @IBAction func commentAction(_ sender: Any) {
        print("Comment")
    }
}
