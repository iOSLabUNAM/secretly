//
//  CommentCollectionViewCell.swift
//  Secretly
//
//  Created by Fernanda Hernandez on 02/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

class CommentCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = "commentXIB"
    
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var authorView: AuthorCommentView!
    
    var comment: Comment? {
        didSet {
             updateView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateView()
    }
    
    func updateView()  {
        guard let comment = comment else {return }
        self.contentLabel.text = comment.content
        self.authorView.author = comment.author
    }

}
