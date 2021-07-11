//
//  FeedCollectionViewController+PostCollectionViewCellDelegate.swift
//  Secretly
//
//  Created by Samuel Arturo Garrido Sánchez on 2021-07-11.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

extension FeedCollectionViewController: PostCollecionViewCellDelegate{
    
    
    func goComment(post: Post) {
        performSegue(withIdentifier: "commentSegue", sender: post)
    }
    
}
