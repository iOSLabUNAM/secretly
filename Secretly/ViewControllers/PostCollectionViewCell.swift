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
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let coomentview = NewCommentViewController()
    
    weak var viewControlle: UIViewController?
    lazy var loggedInView: NewCommentViewController = storyboard.instantiateViewController(withIdentifier: "NewCommentViewController") as! NewCommentViewController
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
    
    @IBAction func commentsView(_ sender: UIStoryboardSegue) {
        
        loggedInView.commentCollection = nil
        loggedInView.comments = []
        loggedInView.postSelected = post
        viewControlle?.modalPresentationStyle = .fullScreen
        viewControlle?.present(loggedInView, animated: true, completion: nil)
        

    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateView()  {
        imageView.image = nil
        guard let post = post else {return }
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
}



    
    


