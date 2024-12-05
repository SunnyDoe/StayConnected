//
//  ProfileViewController.swift
//  combineTest
//
//  Created by Imac on 04.12.24.
//

import UIKit

class ProfileViewController: UIViewController {
    private let viewModel = ProfileViewModel()
    
    private let profileTitle: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log out", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Score"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = UIColor(red: 94/255, green: 99/255, blue: 102/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scoreNumber: UILabel = {
        let label = UILabel()
        label.text = "25"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = UIColor(red: 94/255, green: 99/255, blue: 102/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let scoreStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false

        return stackView
    }()
    
    private let answeredLabel: UILabel = {
        let label = UILabel()
        label.text = "Answered Questions"
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor(red: 94/255, green: 99/255, blue: 102/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private let answeredNumber: UILabel = {
        let label = UILabel()
        label.text = "15"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 94/255, green: 99/255, blue: 102/255, alpha: 1.0)

        return label
    }()
    
    private let answeredQuestionsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor(red: 94/255, green: 99/255, blue: 102/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    
    
    let answeredQuestionsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let infoTitle: UILabel = {
        let label = UILabel()
        label.text = "INFORMATION"
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = UIColor(red: 94/255, green: 99/255, blue: 102/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.addSubview(profileImageView)
        view.addSubview(nameLabel)
        view.addSubview(emailLabel)
        view.addSubview(logoutButton)
        view.addSubview(profileTitle)
        view.addSubview(scoreStackView)
        view.addSubview(answeredQuestionsStackView)
        view.addSubview(infoTitle)

        scoreStackView.addArrangedSubview(scoreLabel)
        scoreStackView.addArrangedSubview(scoreNumber)
        
        answeredQuestionsStackView.addArrangedSubview(answeredLabel)
        answeredQuestionsStackView.addArrangedSubview(answeredNumber)

        
        NSLayoutConstraint.activate([
            profileTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            profileImageView.topAnchor.constraint(equalTo: profileTitle.bottomAnchor, constant: 24),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 33),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            emailLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            infoTitle.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 59),
            infoTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            scoreStackView.topAnchor.constraint(equalTo: infoTitle.bottomAnchor, constant: 29),
            scoreStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scoreStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            answeredQuestionsStackView.topAnchor.constraint(equalTo: scoreStackView.bottomAnchor, constant: 29),
            answeredQuestionsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            answeredQuestionsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }


    private func bindViewModel() {
        profileImageView.image = viewModel.profileImage
        nameLabel.text = viewModel.name
        emailLabel.text = viewModel.email
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }
    
    @objc private func logoutTapped() {
        viewModel.logOut()
    }
}
