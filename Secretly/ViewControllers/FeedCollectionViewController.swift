//
//  FeedCollectionViewController.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 28/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import CoreLocation
import UIKit

class FeedCollectionViewController: UIViewController {
    let feedService = FeedService()
    var posts: [Post]? {
        didSet {
            collectionView.reloadData()
            refreshControl.endRefreshing()
        }
    }

    let refreshControl = UIRefreshControl()
    let postInputView = PostInputViewController()

    @IBOutlet var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadPosts()
    }

    func setupCollectionView() {
        postInputView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        let nib = UINib(nibName: String(describing: PostCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: PostCollectionViewCell.reuseIdentifier)
        collectionView.addSubview(refreshControl)

        refreshControl.addTarget(self, action: #selector(loadPosts), for: UIControl.Event.valueChanged)
    }

    @objc
    func loadPosts() {
        feedService.load { [unowned self] posts in self.posts = posts }
    }

    @IBAction
    func onTapAdd(_: Any) {
        postInputView.clear()
        present(postInputView, animated: true)
    }
}

extension FeedCollectionViewController: PostInputViewDelegate {
    func didCreatePost(post: Post?) {
        guard let upost = post else { return }
        posts?.insert(upost, at: 0)
    }
}
