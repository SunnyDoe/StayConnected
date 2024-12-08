//
//  TagCell.swift
//  combineTest
//
//  Created by Imac on 03.12.24.
//

import UIKit

class TagCell: UICollectionViewCell {
    let tagButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setTitleColor(UIColor(red: 79/255, green: 70/255, blue: 229/255, alpha: 1.0), for: .normal)
        button.backgroundColor = UIColor(red: 238/255, green: 242/255, blue: 255/255, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(tagButton)
        
        NSLayoutConstraint.activate([
            tagButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            tagButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            tagButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            tagButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with text: String) {
        tagButton.setTitle(text, for: .normal)
    }
}
