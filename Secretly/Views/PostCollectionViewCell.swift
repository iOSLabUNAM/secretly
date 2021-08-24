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
    @IBOutlet weak var likeState: UIImageView!
    @IBOutlet weak var commentCounter: UILabel!
    @IBOutlet weak var likeCounter: UILabel!
    @IBOutlet weak var commentState: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapHeart = UITapGestureRecognizer(target: self, action: #selector(self.changeLikeState))
        likeState.addGestureRecognizer(tapHeart)
        likeState.isUserInteractionEnabled = true
        
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(self.changeLikeState))
        doubleTap.numberOfTapsRequired = 2
        imageView.addGestureRecognizer(doubleTap)
        imageView.isUserInteractionEnabled = true
        
        let tapComment = UITapGestureRecognizer(target: self, action: #selector(self.showComments))
        commentState.addGestureRecognizer(tapComment)
        commentState.isUserInteractionEnabled = true
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
        if (post.likesCount ?? 0 > 0){
            self.likeCounter.text = "\(post.likesCount ?? 0) Me gusta"
        }else{
            self.likeCounter.text = ""
        }
        if post.liked{
            likeState.image = UIImage(systemName: "heart.fill")
        }else{
            likeState.image = UIImage(systemName: "heart")
        }
        
    }
    
    @objc func showComments(sender: UITapGestureRecognizer){
        print("COMMENTS")
    }
    
    @objc func changeLikeState(sender: UITapGestureRecognizer){
        likesService?.setLike { [unowned self] result in
            switch result {
            case .success(nil):
                likeState.image = UIImage(systemName: "heart")
                post?.unlike()
                if (post?.likesCount ?? 0 > 0){
                    self.likeCounter.text = "\(post?.likesCount ?? 0) Me gusta"
                }else{
                    self.likeCounter.text = ""
                }
            case .success:
                likeState.image = UIImage(systemName: "heart.fill")
                post?.like()
                if (post?.likesCount ?? 0 > 0){
                    self.likeCounter.text = "\(post?.likesCount ?? 0) Me gusta"
                }else{
                    self.likeCounter.text = ""
                }
            case .failure:
                print("Request fail \(result)")
            }
        }
    }
    
}
