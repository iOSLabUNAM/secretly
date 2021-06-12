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
        return CGSize(width: collectionView.bounds.width, height: 300)
    }
}
