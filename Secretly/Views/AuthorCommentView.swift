//
//  AuthorCommentView.swift
//  Secretly
//
//  Created by Fernanda Hernandez on 10/07/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

class AuthorCommentView: UIView {
    var author: Author? {
        didSet {
            updateContent()
        }
    }

    let stack: UIStackView = {
        let sv = UIStackView()
        sv.alignment = .fill
        sv.distribution = .fill
        sv.axis = .horizontal
        sv.spacing = CGFloat(10.0)
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    let avatarImg: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "person.fill")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let usernameLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Jane Doe"
        lbl.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    convenience init() {
        self.init(frame: .zero)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupConstraints()
    }

    func setupConstraints() {
        self.backgroundColor = .clear
        addSubview(stack)
        stack.addArrangedSubview(avatarImg)
        stack.addArrangedSubview(usernameLbl)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 3),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 3),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 3),
            stack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 3)
        ])

        NSLayoutConstraint.activate([
            avatarImg.widthAnchor.constraint(equalTo: avatarImg.heightAnchor)
        ])
        avatarImg.layer.cornerRadius = self.frame.height / 2.0
    }

    func updateContent() {
        guard let author = author else { return }
        usernameLbl.text = author.name
        ImageLoader.load(author.avatarUrl) { [unowned self] img in self.avatarImg.image = img }
    }

}
