//
//  FeedCollectionViewController.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 28/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit
import CoreLocation

class FeedCollectionViewController: UIViewController {
    let feedService = FeedService()
    var posts: [Post]? {
        didSet {
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    let refreshControl = UIRefreshControl()
    let postInputView = PostInputViewController()

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadPosts()
    }

    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.sectionInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        postInputView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
//        collectionView.isPrefetchingEnabled = true
        collectionView.collectionViewLayout = layout
        let nib = UINib(nibName: String(describing: PostCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: PostCollectionViewCell.reuseIdentifier)
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(self.loadPosts), for: UIControl.Event.valueChanged)
    }

    @objc
    func loadPosts() {
        feedService.load { [unowned self] posts in self.posts = posts }
    }

    @IBAction
    func onTapAdd(_ sender: Any) {
        postInputView.clear()
        present(postInputView, animated: true)
    }
}

extension FeedCollectionViewController: PostInputViewDelegate {
    func didCreatePost(post: Post?) {
        guard let upost = post else { return }
        self.posts?.insert(upost, at: 0)
    }
}
