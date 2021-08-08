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
    let likeService = LikeService()
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
        postInputView.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        let nib = UINib(nibName: String(describing: PostCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: PostCollectionViewCell.reuseIdentifier)
        collectionView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(self.loadPosts), for: UIControl.Event.valueChanged)
    }

    @objc
    func loadPosts() {
        feedService.load { [unowned self] posts in
            self.posts = posts
            
        }
        
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

protocol LikeInputDelegate{
    func likeToPost(postId: Int)
    func dislikeToPost(postId: Int)
}

extension FeedCollectionViewController : LikeInputDelegate {
    
    func dislikeToPost(postId: Int) {
        guard let posts = self.posts else { return }
        let postIndex = posts.firstIndex(where: { $0.id == postId })
        guard let index = postIndex else { return }
        likeService.deleteLike(postId: postId)
        self.posts?[index].liked? = false
    }

    func likeToPost(postId: Int ) {
        guard let posts = self.posts else { return }
        let postIndex = posts.firstIndex(where: { $0.id == postId })
        guard let index = postIndex else { return }
        likeService.createLike(postId: postId)
        self.posts?[index].liked? = true
        
    }
}
