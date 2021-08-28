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
    var likesService: LikesService?
    var post: Post? {
        didSet {
            updateView()
            likesService = LikesService(post: post)
        }
    }
    @IBOutlet weak var authorView: AuthorView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentCounter: UILabel!
    @IBOutlet weak var likesCounter: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    
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
        // Update likes counter label
        self.likesCounter.text = "\(post.likesCount ?? 0) Me gusta"
        // Update like image
        if post.liked ?? false{
            btnLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else{
            btnLike.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func toggleLike(_ sender: UIButton) {
        likesService?.toggleLike { [unowned self] result in
            switch result {
            case .success(nil):
                btnLike.setImage(UIImage(systemName: "heart"), for: .normal)
                post?.toggleLike(isLiked: false)
            case .success:
                btnLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                post?.toggleLike(isLiked: true)
            case .failure:
                print("Failure request \(result)")
            }
            self.likesCounter.text = "\(post?.likesCount ?? 0) Me gusta"
        }
    }
    
}
