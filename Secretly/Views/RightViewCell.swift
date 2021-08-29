//
//  RightViewCell.swift
//  Secretly
//
//  Created by Victor Aceves on 28/08/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

class RightViewCell: UITableViewCell {


    @IBOutlet weak var commentContainerView: UIView!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentContainerView.rounded(radius: 12)
        commentContainerView.backgroundColor = UIColor(hex: "#E1F7CB")
        
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    func configureCell(comment: Comment) {
        commentLabel.text = comment.content
    }
}
