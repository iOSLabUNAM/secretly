//
//  FeedCollectionViewController+UICollectionViewDelegate.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 12/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

extension FeedCollectionViewController: UICollectionViewDelegate {
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: TAP To Like
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "commentSegue"{
            let vc = segue.destination as! CommentViewController
            vc.post = sender as? Post
        }
    }
    
}
extension FeedCollectionViewController: goCommentDelegate{
    func goComment(post: Post) {
        performSegue(withIdentifier: "commentSegue", sender: post)
    }
    
}
