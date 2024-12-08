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
    private let repliesLabel = UILabel()
    private let tagsContainerView = UIView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 0
        
        questionLabel.font = .systemFont(ofSize: 14)
        questionLabel.numberOfLines = 0
        
        repliesLabel.font = .systemFont(ofSize: 12)
        repliesLabel.textColor = .gray

        tagsContainerView.translatesAutoresizingMaskIntoConstraints = false

        let stackView = UIStackView(arrangedSubviews: [titleLabel, questionLabel, tagsContainerView, repliesLabel])
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    func configure(with title: String, question: String, tags: [String]) {
        titleLabel.text = title
        questionLabel.text = question

        tagsContainerView.subviews.forEach { $0.removeFromSuperview() }

        var currentRowView = UIStackView()
        currentRowView.axis = .horizontal
        currentRowView.spacing = 8
        currentRowView.translatesAutoresizingMaskIntoConstraints = false

        tagsContainerView.addSubview(currentRowView)

        var currentRowWidth: CGFloat = 0
        let maxRowWidth: CGFloat = contentView.frame.width - 32

        for tag in tags {
            let tagButton = createTagButton(for: tag)
            let buttonWidth = tagButton.intrinsicContentSize.width + 16

            if currentRowWidth + buttonWidth > maxRowWidth {
                currentRowView = UIStackView()
                currentRowView.axis = .horizontal
                currentRowView.spacing = 8
                currentRowView.translatesAutoresizingMaskIntoConstraints = false
                tagsContainerView.addSubview(currentRowView)

                currentRowWidth = 0
            }

            currentRowView.addArrangedSubview(tagButton)
            currentRowWidth += buttonWidth + 8
        }

        layoutTagRows()
        repliesLabel.text = "Replies: \(Int.random(in: 1...5))"
    }

    private func createTagButton(for tag: String) -> UIButton {
        let tagButton = UIButton()
        tagButton.titleLabel?.font = .systemFont(ofSize: 14)
        tagButton.setTitleColor(UIColor(red: 79/255, green: 70/255, blue: 229/255, alpha: 1.0), for: .normal)
        tagButton.backgroundColor = UIColor(red: 238/255, green: 242/255, blue: 255/255, alpha: 1.0)
        tagButton.layer.cornerRadius = 8
        tagButton.layer.masksToBounds = true
        tagButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        tagButton.setTitle(tag, for: .normal)
        return tagButton
    }

    private func layoutTagRows() {
        var previousRow: UIView? = nil

        for row in tagsContainerView.subviews {
            NSLayoutConstraint.activate([
                row.leadingAnchor.constraint(equalTo: tagsContainerView.leadingAnchor),
                row.trailingAnchor.constraint(lessThanOrEqualTo: tagsContainerView.trailingAnchor)
            ])
            if let previous = previousRow {
                row.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 8).isActive = true
            } else {
                row.topAnchor.constraint(equalTo: tagsContainerView.topAnchor).isActive = true
            }
            previousRow = row
        }

        if let lastRow = tagsContainerView.subviews.last {
            lastRow.bottomAnchor.constraint(equalTo: tagsContainerView.bottomAnchor).isActive = true
        }
    }
}
