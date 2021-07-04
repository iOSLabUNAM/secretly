//
//  PreviewPostVIew.swift
//  Secretly
//
//  Created by Luis Ezcurdia on 18/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import UIKit

class PreviewPostView: UIView {
    public var content: String? {
        didSet {
            self.contentLbl.text = content
        }
    }
    public var image: UIImage? {
        didSet {
            self.imgView.image = image
        }
    }
    let imgView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .clear
        iv.contentMode = .scaleToFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    let contentLbl: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        lbl.textColor = .white
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    func clear() {
        self.imgView.image = nil
        self.image = nil
        self.contentLbl.text = nil
        self.content = nil
    }

    private func setupLayout() {
        addSubview(imgView)
        addSubview(contentLbl)
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: self.topAnchor),
            imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
