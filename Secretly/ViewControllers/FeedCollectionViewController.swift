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
    let createPostService = CreatePostService()
    var posts: [Post]? {
        didSet {
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
            self.postInputView.clear()
        }
    }
    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?

    let refreshControl = UIRefreshControl()
    @IBOutlet weak var postInputView: PostInputView!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        loadPosts()
        enableBasicLocationServices()
    }

    func enableBasicLocationServices() {
        locationManager.delegate = self
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            print("Disable location features")
        case .authorizedWhenInUse, .authorizedAlways:
            print("Enable location features")
        @unknown default:
            fatalError()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingLocation()
    }

    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
        super.viewWillDisappear(animated)
    }

    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.prefetchDataSource = self
        let nib = UINib(nibName: String(describing: PostCollectionViewCell.self), bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: PostCollectionViewCell.reuseIdentifier)
        collectionView.addSubview(refreshControl)

        refreshControl.addTarget(self, action: #selector(self.loadPosts), for: UIControl.Event.valueChanged)

        postInputView.delegate = self
        postInputView.locationSource = self
    }

    let feedService = FeedService()

    @objc
    func loadPosts() {
        feedService.load { [unowned self] posts in self.posts = posts }
    }
}

// MARK: - PostInputViewDelegate
extension FeedCollectionViewController: PostInputViewDelegate {
    func colorPickerPresent(_ colorPicker: UIColorPickerViewController) {
        present(colorPicker, animated: true)
    }

    func onPostButtonTapped() {
        guard let post = postInputView.source else { return }
        createPostService.create(post) { [unowned self] result in
            switch result {
            case .success(let post):
                if let upost = post {
                    self.posts?.insert(upost, at: 0)
                }
            case .failure(let err):
                self.errorAlert(err)
            }
        }
    }

    private func errorAlert(_ error: Error) {
        let err = error as? Titleable
        let alert = UIAlertController(title: (err?.title ?? "Server Error"), message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
