//
//  FeedCollectionViewController+PostCollectionViewCellDelegate.swift
//  Secretly
//
//  Created by Victor Aceves on 28/08/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation

extension FeedCollectionViewController: PostCollectionViewCellDelegate {
      func didButtonPressed() {
        let commentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        self.navigationController?.pushViewController(commentsViewController, animated: true)
      }

}
