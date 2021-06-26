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
    @IBOutlet weak var likeState: UIImageView!
    @IBOutlet weak var commentCounter: UILabel!
    @IBOutlet weak var likeMsm: UILabel!
    
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
        self.likeMsm.text = getLikeMessage(post: post)
        // self.likeState = setLikeState(post: post)
    }
    
    func getLikeMessage(post: Post) -> String {
        let likeCount = post.likesCount ?? 0
        let likeAuthors = post.likes
        
        var authorsResume = ""
        
        if(likeCount == 1) {
            authorsResume = "\(likeAuthors?[0].author?.name ?? "") has liked this photo"
        }
        
        if(likeCount >= 2){
            let nameOne = likeAuthors?[0].author?.name ?? ""
            let nameTwo = likeAuthors?[1].author?.name ?? ""
            authorsResume = "\(nameOne), \(nameTwo) and \(likeCount) more, liked this photo"
        }
        
        return authorsResume
    }
    
    /* func setLikeState(post: Post) -> UIImageView {
        let userName = post.user?.username
        let likeAuthors = post.likes
        
        let userLikedItsPhoto = likeAuthors!.filter({$0.author?.name == userName})
        
        var image = UIImageView(named: "image")
        if(userLikedItsPhoto.count == 1){
            image =
        }
        
        return image
    } */
}
