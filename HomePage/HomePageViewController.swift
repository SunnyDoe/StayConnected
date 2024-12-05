//
//  HomePageViewController.swift
//  combineTest
//
//  Created by Imac on 29.11.24.
//

import UIKit
import SwiftUI

class HomePageViewController: UIViewController {

    let questionLbl: UILabel = {
        let label = UILabel()
        label.text = "Questions"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    let generalButton: UIButton = {
        let button = UIButton()
        button.setTitle("General", for: .normal)
        button.backgroundColor = UIColor(red: 78/255, green: 83/255, blue: 162/255, alpha: 1.0) // default ად უნდა მქონდეს ეს ფერი და რომ დავაჭერ personal შეცვალოს ფერები
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    let personalButton: UIButton = {
        let button = UIButton()
        button.setTitle("Personal", for: .normal)
        button.backgroundColor = UIColor(red: 119/255, green: 126/255, blue: 153/255, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        return button
    }()
    
    let noQuestionsLbl: UILabel = {
        let label = UILabel()
        label.text = "No questions yet"
        label.font = UIFont(name: "", size: 15)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let firstToAskLbl: UILabel = {
        let label = UILabel()
        label.text = "Be the first to ask one"
        label.font = UIFont(name: "", size: 15)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let ifEmptyImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "IfEmpty"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUi()
        setupButtonActions()
        updateButtonStyles(activeButton: generalButton)

        
    }
    private func setupUi() {
        view.addSubview(questionLbl)
        view.addSubview(addButton)
        view.addSubview(buttonStackView)
        view.addSubview(noQuestionsLbl)
        view.addSubview(firstToAskLbl)
        view.addSubview(ifEmptyImage)


        buttonStackView.addArrangedSubview(generalButton)
        buttonStackView.addArrangedSubview(personalButton)


        NSLayoutConstraint.activate([
            questionLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            questionLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            
            addButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 7),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            
            buttonStackView.topAnchor.constraint(equalTo: questionLbl.bottomAnchor, constant: 20),
            buttonStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 12),
            buttonStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -12),
            buttonStackView.heightAnchor.constraint(equalToConstant: 39),

            noQuestionsLbl.topAnchor.constraint(equalTo: buttonStackView.bottomAnchor, constant: 91),
            noQuestionsLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            firstToAskLbl.topAnchor.constraint(equalTo: noQuestionsLbl.bottomAnchor, constant: 13),
            firstToAskLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            ifEmptyImage.topAnchor.constraint(equalTo: firstToAskLbl.bottomAnchor, constant: 19),
            ifEmptyImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }
    
    
    private func setupButtonActions() {
        generalButton.addTarget(self, action: #selector(generalButtonTapped), for: .touchUpInside)
        personalButton.addTarget(self, action: #selector(personalButtonTapped), for: .touchUpInside)
    }

    @objc private func generalButtonTapped() {
        updateButtonStyles(activeButton: generalButton)
        showGeneralContent()
    }

    @objc private func personalButtonTapped() {
        updateButtonStyles(activeButton: personalButton)
        showPersonalContent()
    }

    private func updateButtonStyles(activeButton: UIButton) {
        generalButton.backgroundColor = activeButton == generalButton
            ? UIColor(red: 78/255, green: 83/255, blue: 162/255, alpha: 1.0)
            : UIColor(red: 119/255, green: 126/255, blue: 153/255, alpha: 1.0)
        
        personalButton.backgroundColor = activeButton == personalButton
            ? UIColor(red: 78/255, green: 83/255, blue: 162/255, alpha: 1.0)
            : UIColor(red: 119/255, green: 126/255, blue: 153/255, alpha: 1.0)
    }

    private func showGeneralContent() {
        noQuestionsLbl.text = "No questions yet"
        firstToAskLbl.text = "Be the first to ask one "
    }

    private func showPersonalContent() {
        noQuestionsLbl.text = "Got a question in mind?"
        firstToAskLbl.text = "Ask it and wait for like-minded people  to answer"
    }

}
