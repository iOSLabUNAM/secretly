//
//  FeedCollectionViewController+PostCollectionViewCellDelegate.swift
//  Secretly
//
//  Created by Victor Aceves on 28/08/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

extension FeedCollectionViewController: PostCollectionViewCellDelegate {
    func didButtonPressed(post: Post) {
        let commentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        commentsViewController.post = post
        //callBack block will execute when user back from SecondViewController.
        commentsViewController.callBack = { (reload: Bool) in
            self.reload = reload
        }
        // self.navigationController?.pushViewController(commentsViewController, animated: true)
    }
}
