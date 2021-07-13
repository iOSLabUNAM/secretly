//
//  FeedCollectionViewController+UICollectionViewDelegateFlowLayout .swift
//  Secretly
//
//  Created by Luis Ezcurdia on 12/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

extension FeedCollectionViewController: UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow:CGFloat = 1
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
              
        let totalSpacing = Int(flowLayout.sectionInset.left) + Int(flowLayout.sectionInset.right) + Int((numberOfItemsPerRow-1) * flowLayout.minimumInteritemSpacing)
        let width = (Int(collectionView.bounds.width) - totalSpacing)/Int(numberOfItemsPerRow)
        return CGSize(width: width, height: 300)
    }
    
}
