//
//  CommentViewCellTableViewCell.swift
//  Secretly
//
//  Created by Samuel Arturo Garrido Sánchez on 2021-07-02.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

class CommentViewCellTableViewCell: UITableViewCell {
    
    var comment: Comment? {
        didSet{
            print("Primero se realiza la asignaciòn")
            guard let unwrapComment = comment else { return }
            usernameLabel.text = unwrapComment.autor?.username ?? "Anonymous"
            commentLabel.text = unwrapComment.content
            if let unwrapImage = unwrapComment.autor?.avatarUrl{
                ImageLoader.load(unwrapImage) { [unowned self] img in self.imageUser.image = img }
            }else{
                self.imageUser.image = UIImage(named: "animated")
            }
            activateConstraints()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let imageUser:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 13
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let usernameLabel:UILabel = {
        let label = UILabel()
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 18)
        label.sizeToFit()
        label.numberOfLines = 1
        return label
    }()
    
    private let commentLabel:UILabel = {
        let label = UILabel()
        label.contentMode = .scaleAspectFit
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    private let verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .leading
        return stack
    }()
    
    private func activateConstraints(){
        addSubview(verticalStack)
        verticalStack.addArrangedSubview(horizontalStack)
        horizontalStack.addArrangedSubview(imageUser)
        horizontalStack.addArrangedSubview(usernameLabel)
        verticalStack.addArrangedSubview(commentLabel)
        
        NSLayoutConstraint.activate([
            verticalStack.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            verticalStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            verticalStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            verticalStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            imageUser.widthAnchor.constraint(equalToConstant: 25),
            imageUser.heightAnchor.constraint(equalToConstant: 25),
        ])
    }
}
