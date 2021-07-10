//
//  FeedCollectionViewController+UICollectionViewDataSource .swift
//  Secretly
//
//  Created by Luis Ezcurdia on 12/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

extension FeedCollectionViewController: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return posts?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PostCollectionViewCell.reuseIdentifier, for: indexPath) as! PostCollectionViewCell

        cell.post = posts?[indexPath.row]
        return cell
    }
}
