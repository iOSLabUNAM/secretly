//
//  PostCollectionViewCell.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 28/05/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "feedPostCell"
    var imgP: UIImage?
    var post: Post? {
        didSet {
           updateView()
        }
    }
    var likePostState:Bool?
    var like :Like?{
        didSet{
            updateView()
        }
    }
    
    @IBOutlet weak var bigLikeState: UIImageView!
    @IBOutlet weak var authorView: AuthorView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var likeState: UIImageView!
    @IBOutlet weak var commentCounter: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tap=UITapGestureRecognizer(target: self, action: #selector(tapLike(_:)))
        let doubleTap=UITapGestureRecognizer(target: self, action: #selector(tapLike(_:)))
        doubleTap.numberOfTapsRequired=2
        imageView.isUserInteractionEnabled=true
        imageView.addGestureRecognizer(doubleTap)
        likeState.isUserInteractionEnabled=true
        likeState.addGestureRecognizer(tap)
    }
    @objc func tapLike(_ sender: UITapGestureRecognizer) {
        guard let post=post, let id=post.id, let postState=post.liked else{return}
        let updateLike=Like(id: id, createdAt: Date(), updatedAt: Date())
        
        if postState || self.likePostState ?? postState {
            print("Tiene like")
//            Eliminar like
            let delLike=DeleteLikeService(id:id)
            delLike.delete(updateLike) { resultDelLike in
                switch resultDelLike {
                case .success:
                    print("Like borrado")
                    self.likePostState=false
                    self.updatePost(id: id, sum: -1,state: self.likePostState!)
                case .failure:
                    print("Like NO borrado")
                    self.bigLikeState.isHidden=true
                    self.likeState.tintColor = .red

                }
            }
            
        }else if (postState || self.likePostState ?? postState) == false {
            print("No tiene like")
            let createLike=CreateLikeService(id: id)
            createLike.create(updateLike) { resultDelLike in
                switch resultDelLike {
                case .success:
                    print("Like creado")
                    self.likePostState=true
                    self.updatePost(id: id, sum: 1,state: self.likePostState!)
                    self.bigLikeState.isHidden=false
                    self.likeState.tintColor = .white
                case .failure:
                    print("Like NO creado")
                }
            }
        }
        updateView()
    }
    func updatePost(id:Int,sum:Int,state:Bool) {
        self.likePostState=state
        guard let post = post, let id=post.id, let countLikes=post.likesCount else{return}
        let newLikes = countLikes + sum
        if let imgP = post.image {
            ImageLoader.load(imgP.mediumUrl) { img in self.imageView.image = img }
        }
        let updatePost=UpdatePostService(id: id)
        
        if let postImg = post.image {
            ImageLoader.load(postImg.mediumUrl) { img in self.imgP = img }
        }
        
        
        let newPost=Post(content: post.content, backgroundColor: post.backgroundColor, latitude: post.latitude, longitude: post.longitude, image: imgP, likesCount: newLikes, liked: state)
        updatePost.update(newPost) { resultUpdatePost in
            switch resultUpdatePost {
            case .success:
                print("Post updated")
                self.likeLabel.text=String(describing: newLikes)
            case .failure:
                print("Post not updated")
            }
        }
    }

    func updateView() {
        imageView.image = nil
        guard let post = post else { return }
        self.likePostState=post.liked
        if let color = UIColor(hex: post.backgroundColor) {
            self.backgroundColor = color
        }
        checkStatus()
        self.contentLabel.text = post.content
        self.commentCounter.text = String(describing: post.commentsCount ?? 0)
        if let postImg = post.image {
            ImageLoader.load(postImg.mediumUrl) { img in self.imageView.image = img }
        }
        self.authorView.author = post.user
    }
    
    func checkStatus(){
        guard let post=post, let likePostState=post.liked, let likesCount = post.likesCount   else{return}
        if likePostState || self.likePostState!{
            likeState.tintColor = .red
            bigLikeState.isHidden = true
        }else if (likePostState || self.likePostState!)==false  {
            likeState.tintColor = .white
            bigLikeState.isHidden = true
        }
        
        likeLabel.text = String(describing: likesCount)
    }
}
