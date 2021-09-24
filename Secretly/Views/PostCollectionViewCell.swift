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
    @IBOutlet weak var commentCounter: UILabel!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var likeBtn: UIButton!

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
    }
    
    @IBAction func onLikeTapped(_ sender: UIButton) {
        var lod = false
        likeService?.likeOrDislikePost(complete: { [unowned self] res in
            switch res {
            case .success(nil):
                likeBtn.setImage(UIImage(systemName: "heart"), for: .normal)
                post?.onLikeOrDislike(likeOrUnlike: lod)
                lod = !lod
                if(post?.likeCount ?? 0 > 0) {
                    self.likeCount.text = "\(post?.likeCount ?? 0) Likes"
                } else {
                    self.likeCount.text = ""
                }
            case .success:
                likeBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                post?.onLikeOrDislike(likeOrUnlike: lod)
                lod = !lod
                if(post?.likeCount ?? 0 > 0) {
                    self.likeCount.text = "\(post?.likeCount ?? 0) Likes"
                } else {
                    self.likeCount.text = ""
                }
            case .failure:
                print("Request failed, cause: \(res)")
            }
        })
    }
}
