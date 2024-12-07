//
//  QuestionCell.swift
//  StayConnected
//
//  Created by Sandro Tsitskishvili on 05.12.24.
//

import UIKit

class QuestionCell: UITableViewCell {
    private let titleLabel = UILabel()
    private let questionLabel = UILabel()
    private var tagButtons: [UIButton] = []
    private let repliesLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        titleLabel.font = .boldSystemFont(ofSize: 16)
        questionLabel.font = .systemFont(ofSize: 14)
        
        repliesLabel.font = .systemFont(ofSize: 12)
        repliesLabel.textColor = .gray
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, questionLabel, repliesLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }

    func configure(with title: String, question: String, tags: [String]) {
        titleLabel.text = title
        questionLabel.text = question

        tagButtons.forEach { $0.removeFromSuperview() }
        tagButtons.removeAll()

        var previousButton: UIButton? = nil
        var leadingAnchor: NSLayoutXAxisAnchor = contentView.leadingAnchor
        
        tags.forEach { tag in
            let tagButton = UIButton()
            tagButton.titleLabel?.font = .systemFont(ofSize: 14)
            tagButton.setTitleColor(UIColor(red: 79/255, green: 70/255, blue: 229/255, alpha: 1.0), for: .normal)
            tagButton.backgroundColor = UIColor(red: 238/255, green: 242/255, blue: 255/255, alpha: 1.0)
            tagButton.layer.cornerRadius = 8
            tagButton.layer.masksToBounds = true
            tagButton.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
            tagButton.setTitle(tag, for: .normal)
            
            tagButton.translatesAutoresizingMaskIntoConstraints = false
            
            tagButton.setContentHuggingPriority(.required, for: .horizontal)
            tagButton.setContentCompressionResistancePriority(.required, for: .horizontal)

            contentView.addSubview(tagButton)
            tagButtons.append(tagButton)

            if let previous = previousButton {
                tagButton.leadingAnchor.constraint(equalTo: previous.trailingAnchor, constant: 8).isActive = true
            } else {
                tagButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
            }
            tagButton.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 8).isActive = true

            previousButton = tagButton
        }

        repliesLabel.text = "Replies: \(Int.random(in: 1...5))"
    }
}
