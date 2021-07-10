//
//  PostInputViewController.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 19/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit
import CoreLocation

struct EmptyPostError: Error {}

protocol PostInputViewDelegate {
    func didCreatePost(post: Post?)
}

class PostInputViewController: UIViewController, UINavigationControllerDelegate {
    let createPostService = CreatePostService()
    @IBOutlet weak var contentTxt: UITextField!
    @IBOutlet weak var imgPickerButton: UIButton!
    @IBOutlet weak var colorPickerButton: UIButton!
    @IBOutlet weak var previewPost: PreviewPostView!
    var source: Post?
    var delegate: PostInputViewDelegate?

    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?

    let imgPicker: UIImagePickerController = {
        let view = UIImagePickerController()
        view.mediaTypes = ["public.image"]
        return view
    }()
    let colorPicker = UIColorPickerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imgPickerButton.layer.cornerRadius = 8
        colorPickerButton.layer.cornerRadius = 8
        colorPicker.delegate = self
        imgPicker.delegate = self
        contentTxt.delegate = self
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

    @IBAction
    func didTapPublish(_ sender: Any) {
        do {
            try self.createPost()
            self.dismiss(animated: true)
        } catch let err {
            self.errorAlert(err)
        }
    }

    @IBAction
    func didTapCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction
    func didTapImagePicker(_ sender: Any) {
        present(imageSourceSelectAlert, animated: true)
    }

    private lazy var imageSourceSelectAlert: UIAlertController = {
        let alert = UIAlertController(title: "Select source", message: "Select the image source for your post.", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: openCamera)
        let libraryAction = UIAlertAction(title: "Library", style: .default, handler: openLibrary)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        alert.addAction(cameraAction)
        alert.addAction(libraryAction)
        alert.addAction(cancelAction)

        return alert
    }()

    private func openCamera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.imgPicker.sourceType = .camera
        } else {
            self.imgPicker.sourceType = .photoLibrary
        }
        self.present(imgPicker, animated: true)
    }

    private func openLibrary(_ sender: Any) {
        self.imgPicker.sourceType = .savedPhotosAlbum
        self.present(imgPicker, animated: true)
    }

    @IBAction
    func didTapColorPicker(_ sender: Any) {
        colorPicker.selectedColor = previewPost.backgroundColor ?? .clear
        present(colorPicker, animated: true)
    }

    private func createPost() throws {
        let post = try self.buildPost()
        createPostService.create(post) { [unowned self] result in
            switch result {
            case .success(let post):
                delegate?.didCreatePost(post: post)
            case .failure(let err):
                self.errorAlert(err)
            }
        }
    }

    private func buildPost() throws -> Post {
        guard let postText = contentTxt.text else {
            throw EmptyPostError()
        }
        var post = Post(
            content: postText,
            backgroundColor: previewPost.backgroundColor?.hexString ?? "#3366CC",
            latitude: currentLocation?.latitude,
            longitude: currentLocation?.longitude,
            likesCount: 0,
            liked:false
        )
        if let uimage = previewPost.image {
            post.imageData = uimage.encodeBase64()
        }
        return post
    }

    func errorAlert(_ error: Error) {
        let err = error as? Titleable
        let alert = UIAlertController(title: (err?.title ?? "Server Error"), message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }

    public func clear() {
        source = nil
        contentTxt?.text = ""
        previewPost?.clear()
    }
}
