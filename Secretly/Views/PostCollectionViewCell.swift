//
//  PostCollectionViewCell.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 28/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

protocol PostCollecionViewCellDelegate: AnyObject{
    func goComment(post: Post)
}

class PostCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "feedPostCell"
    
    weak var delegate:PostCollecionViewCellDelegate?
    var likeService: LikeService?
    
    var post: Post? {
        didSet {
           updateView()
        }
    }
    
    @IBOutlet weak var authorView: AuthorView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeState: UIImageView!
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var numLikes: UILabel!
    
    @IBAction func onCommentPressed(_ sender: UIButton) {
        guard let unwrapPost = post else { return }
        delegate?.goComment(post: unwrapPost)
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(setLike))
        tapGesture.numberOfTapsRequired = 2
        self.imageView.addGestureRecognizer(tapGesture)
    }

    
    func updateCountedLikes(numLikes:Int){
        commentButton.setTitle("\(numLikes)", for: .normal)
    }
    
    func updateView() {
        guard let post = post else { return }
        if let color = UIColor(hex: post.backgroundColor) {
            self.imageView.backgroundColor = color
        }
        self.contentLabel.text = post.content
        if let postImg = post.image {
            ImageLoader.load(postImg.mediumUrl) { img in self.imageView.image = img }
        }
        self.authorView.author = post.user
        
    }
    
    @objc func setLike(){
        self.numLikes.text = "\(post?.numLikes ?? 0 + 1)"
        self.likeState.tintColor = .red
        likeService?.create(Like()) { [unowned self] result in
            switch result{
                case .success(_):
                    self.numLikes.text = "\(post?.numLikes ?? 0 + 1)"
                    self.likeState.tintColor = .red
                    break
                        
                case .failure(let error):
                    print(error)
                    
            }
        }
    }
}
