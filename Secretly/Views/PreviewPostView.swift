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
    
    let imgView2: UIImageView = {
        let iv2 = UIImageView()
        iv2.backgroundColor = .clear
        iv2.contentMode = .scaleToFill
        iv2.translatesAutoresizingMaskIntoConstraints = false
        return iv2
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
        self.imgView2.image = nil
    }

    private func setupLayout() {
        addSubview(imgView)
        addSubview(contentLbl)
        addSubview(imgView2)
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: self.topAnchor, constant: 4),
            imgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4),
            imgView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 4),
            imgView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 4),
            contentLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
}
