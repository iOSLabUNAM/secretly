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
            contentLbl.text = content
        }
    }

    public var image: UIImage? {
        didSet {
            imgView.image = image
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
        imgView.image = nil
        image = nil
        contentLbl.text = nil
        content = nil
    }

    private func setupLayout() {
        addSubview(imgView)
        addSubview(contentLbl)
        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: topAnchor),
            imgView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imgView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imgView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentLbl.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentLbl.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentLbl.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}
