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
    
    var post: Post? {
        didSet {
           updateView()
        }
    }
    @IBOutlet weak var authorView: AuthorView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentCounter: UILabel!
    @IBOutlet weak var likeState: UIButton!
    @IBOutlet weak var likeCounter: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func onLikeClicked(_ sender: Any) {
        let like = Like(postId: (self.post?.id)!)
        let likeService = LikeService(post: post!)
        if (post?.liked)!{
            deleteLike(like: like, likeService: likeService)
        }else{
            createLike(like: like, likeService: likeService)
        }
    }
    
    func createLike(like: Like, likeService: LikeService){
        likeService.create(like) {
            [unowned self] result in
            switch result {
                case .success(let like):
                    print("there is a new like \(like?.id ?? 0)")
                    DispatchQueue.main.async {
                        self.post!.liked = true
                        self.likeState.tintColor = .red
                        self.likeState.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                        let newCounter =
                            Int(self.likeCounter.text!)! + 1
                        self.likeCounter.text = String(newCounter)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }
    
    func deleteLike(like: Like, likeService: LikeService){
        likeService.delete(like) {
            [unowned self] result in
            switch result {
            case .success(let _):
                    print("like deleted")
                    DispatchQueue.main.async {
                        let newCounter =
                            Int(self.likeCounter.text!)! - 1
                        self.likeCounter.text = String(newCounter)
                        self.likeState.tintColor = .white
                        self.likeState.setImage(UIImage(systemName: "heart"), for: .normal)
                        self.post!.liked = false
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
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
        if post.liked!{
            self.likeState.tintColor = .red
            self.likeState.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            self.likeState.tintColor = .white
            self.likeState.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
}
