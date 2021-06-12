//
//  PostInputView.swift
//  Secretly
//
//  Created by Ivan Quintana on 06/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

protocol PostInputViewDelegate {
    func colorPickerPresent(_ colorPicker: UIColorPickerViewController)
    func onPostButtonTapped()
}

struct EmptyPostError: Error {}

class PostInputView: UIView {
    struct UIConstants {
        let standardPadding: CGFloat = 8
    }

    private var colorPicker = UIColorPickerViewController()

    var delegate: PostInputViewDelegate?
    let contants = UIConstants()
    public var source: Post?

    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "What do you want to say?"
        label.textColor = .text
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let postTextView: UITextView = {
        let view = UITextView()
        view.autocorrectionType = .no
        view.backgroundColor = .tint
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 20)
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .foreground
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return button
    }()

    let colorPickerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Color", for: .normal)
        button.backgroundColor = .foreground
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayout()
    }

    private func setupLayout() {
        self.backgroundColor = .clear

        let padding = contants.standardPadding
        self.addSubview(placeholderLabel)
        NSLayoutConstraint.activate([
            placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding * 2),
            placeholderLabel.heightAnchor.constraint(equalToConstant: padding * 1.5),
            placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            placeholderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
        ])

        postTextView.delegate = self
        self.addSubview(postTextView)
        NSLayoutConstraint.activate([
            postTextView.topAnchor.constraint(equalTo: placeholderLabel.bottomAnchor, constant: padding / 2),
            postTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            postTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            postTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75)
        ])

        self.addSubview(colorPickerButton)
        NSLayoutConstraint.activate([
            colorPickerButton.topAnchor.constraint(equalTo: postTextView.topAnchor),
            colorPickerButton.heightAnchor.constraint(equalTo: postTextView.heightAnchor, multiplier: 0.45),
            colorPickerButton.leadingAnchor.constraint(equalTo: postTextView.trailingAnchor, constant: padding),
            colorPickerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
        ])

        postButton.isEnabled = false
        postButton.backgroundColor = .background

        self.addSubview(postButton)
        NSLayoutConstraint.activate([
            postButton.bottomAnchor.constraint(equalTo: postTextView.bottomAnchor),
            postButton.heightAnchor.constraint(equalTo: postTextView.heightAnchor, multiplier: 0.45),
            postButton.leadingAnchor.constraint(equalTo: postTextView.trailingAnchor, constant: padding),
            postButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding)
        ])
        setupTargets()
    }

    private func setupTargets() {
        colorPicker.delegate = self
        colorPickerButton.addTarget(self, action: #selector(colorPickerButtonTapped), for: .touchUpInside)
        postButton.addTarget(self, action: #selector(delegatePostButtonTapped), for: .touchUpInside)

    }

    func clear() {
        postTextView.text = ""
        postTextView.backgroundColor = .tint
        postButton.backgroundColor = .foreground
    }

    @objc
    private func delegatePostButtonTapped() {
        try? buildSource() // TODO: render alert
        delegate?.onPostButtonTapped()
    }

    private func buildSource() throws {
        guard let postText = postTextView.text else {
            throw EmptyPostError()
        }
        self.source = Post(
            content: postText,
            backgroundColor: postTextView.backgroundColor?.hexString ?? "#3366CC",
            image: UIImage(named: "kawai")
        )
    }
}

extension PostInputView: UIColorPickerViewControllerDelegate {
    @objc func colorPickerButtonTapped() {
        colorPicker.selectedColor = postTextView.backgroundColor ?? .clear
        delegate?.colorPickerPresent(colorPicker)
    }

    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        postTextView.backgroundColor = viewController.selectedColor.pastel()
    }
}

extension PostInputView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let isValidText = !textView.text.isBlank
        postButton.isEnabled = isValidText
        postButton.backgroundColor = isValidText ? .foreground : .background
    }
}
