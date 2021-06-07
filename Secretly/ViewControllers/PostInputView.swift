//
//  PostInputView.swift
//  Secretly
//
//  Created by Ivan Quintana on 06/06/21.
//  Copyright © 2021 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

class PostInputView: UIView {
    struct UIConstants {
        let standardPadding: CGFloat = 8
    }
    
    let contants = UIConstants()
    
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "What do you want to say?"
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let postTextView: UITextView = {
        let view = UITextView()
        view.backgroundColor = .lightGray
        view.textColor = .white
        view.font = .boldSystemFont(ofSize: 20)
        view.textAlignment = .center
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .gray
        button.layer.cornerRadius = 15
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        return button
    }()
    
    let colorPickerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Color", for: .normal)
        button.backgroundColor = .magenta
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
    
    func setupLayout() {
        let padding = contants.standardPadding
        
        self.backgroundColor = .clear
        
        self.addSubview(placeholderLabel)
        placeholderLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding * 2).isActive = true
        placeholderLabel.heightAnchor.constraint(equalToConstant: padding * 1.5).isActive = true
        placeholderLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        placeholderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        
        self.addSubview(postTextView)
        postTextView.topAnchor.constraint(equalTo: placeholderLabel.bottomAnchor, constant: padding / 2).isActive = true
        postTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding).isActive = true
        postTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding).isActive = true
        postTextView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        postTextView.delegate = self
        
        self.addSubview(colorPickerButton)
        colorPickerButton.topAnchor.constraint(equalTo: postTextView.topAnchor).isActive = true
        colorPickerButton.heightAnchor.constraint(equalTo: postTextView.heightAnchor, multiplier: 0.45).isActive = true
        colorPickerButton.leadingAnchor.constraint(equalTo: postTextView.trailingAnchor, constant: padding).isActive = true
        colorPickerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        
        self.addSubview(postButton)
        postButton.bottomAnchor.constraint(equalTo: postTextView.bottomAnchor).isActive = true
        postButton.heightAnchor.constraint(equalTo: postTextView.heightAnchor, multiplier: 0.45).isActive = true
        postButton.leadingAnchor.constraint(equalTo: postTextView.trailingAnchor, constant: padding).isActive = true
        postButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding).isActive = true
        postButton.isEnabled = false
    }
    
    func clear() {
        postTextView.text = ""
        postTextView.backgroundColor = .lightGray
        postButton.backgroundColor = .gray
        postButton.setTitleColor(.lightGray, for: .normal)
    }
}

extension PostInputView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let isValidText = !textView.text.isEmptyORWhiteSpaces
        postButton.isEnabled = isValidText
        postButton.backgroundColor = isValidText ? .systemPink : .gray
        postButton.setTitleColor(isValidText ? .white : .lightGray, for: .normal)
    }
}

extension String {
    var isEmptyORWhiteSpaces: Bool {
        return self.isEmpty || self.trimmingCharacters(in: .whitespaces) == ""
    }
}
