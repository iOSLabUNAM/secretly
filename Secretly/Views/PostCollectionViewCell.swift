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
        
        let imageName = post.liked ?? false ? "heart.fill" : "heart"
        likeState.setImage(UIImage(systemName: imageName), for: .normal)
        
    }
    
    @IBAction func likeOnTap(_ sender: UIButton) {
        likeService?.action{ [unowned self] result in
            var imageName = "heart"
            switch result {
            case .success(nil):
                post?.toggleLike(state: "dec")
            case .success:
                imageName = "heart.fill"
                post?.toggleLike(state: "inc")
            case .failure:
                print("No se pudo actualizar el like")
            }
            likeState.setImage(UIImage(systemName: imageName ),for: .normal)
        }
    }
}
