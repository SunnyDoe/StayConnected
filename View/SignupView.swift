//
//  SignupView.swift
//  StayConnected
//
//  Created by Sandro Tsitskishvili on 29.11.24.
//

import UIKit

class SignUpView: UIViewController {
    
    private let fullNameTextField = UITextField()
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let confirmPasswordTextField = UITextField()
    private let signUpButton = UIButton(type: .system)
    private let statusLabel = UILabel()
    
    private let viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "Sign up"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        configureTextField(fullNameTextField, placeholder: "Full Name", tag: 0)
        configureTextField(emailTextField, placeholder: "Email", tag: 1)
        configureTextField(passwordTextField, placeholder: "Enter Password", isSecure: true, tag: 2)
        configureTextField(confirmPasswordTextField, placeholder: "Confirm Password", isSecure: true, tag: 3)
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = UIColor.systemPurple
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.layer.cornerRadius = 8
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        view.addSubview(signUpButton)
        
        statusLabel.textColor = .red
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.numberOfLines = 0
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)
        
        let stackView = UIStackView(arrangedSubviews: [fullNameTextField, emailTextField, passwordTextField, confirmPasswordTextField])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            fullNameTextField.heightAnchor.constraint(equalToConstant: 50),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            signUpButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            statusLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 16),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func configureTextField(_ textField: UITextField, placeholder: String, isSecure: Bool = false, tag: Int) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = isSecure
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = tag
        textField.delegate = self
        view.addSubview(textField)
    }
    
    private func bindViewModel() {
        updateSignUpButtonState()
    }
    
    private func updateSignUpButtonState() {
        signUpButton.isEnabled = viewModel.isSignUpEnabled
        signUpButton.alpha = viewModel.isSignUpEnabled ? 1.0 : 0.5
    }
    
    @objc private func signUpTapped() {
        viewModel.signUp { [weak self] success, message in
            self?.statusLabel.textColor = success ? .green : .red
            self?.statusLabel.text = message
        }
    }
}

extension SignUpView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            viewModel.fullName = textField.text ?? ""
        case 1:
            viewModel.email = textField.text ?? ""
        case 2:
            viewModel.password = textField.text ?? ""
        case 3:
            viewModel.confirmPassword = textField.text ?? ""
        default:
            break
        }
        updateSignUpButtonState()
    }
}
