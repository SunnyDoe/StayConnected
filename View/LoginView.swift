//
//  ViewController.swift
//  StayConnected
//
//  Created by Sandro Tsitskishvili on 28.11.24.
//

import UIKit

class LoginView: UIViewController {
    
    private let viewModel = AuthViewModel()
    
    private let emailField = UITextField()
    private let passwordField = UITextField()
    private let loginButton = UIButton()
    private let loginLabel = UILabel()
    private let emailLabel = UILabel()
    private let passwordLabel = UILabel()
    private let emailContainer = UIView()
    private let passwordContainer = UIView()
    private let forgotPasswordButton = UIButton()
    private let newToLabel = UILabel()
    private let signUpButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        setupLogin()
        setupPassword()
        setupConstraints()
    }
    
    private func setupLogin() {
        loginLabel.text = "Log in"
        loginLabel.textColor = .black
        loginLabel.font = .systemFont(ofSize: 30)
        loginLabel.textAlignment = .center
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loginLabel)
        
        emailContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emailContainer)
        
        emailLabel.text = "Email"
        emailLabel.textColor = .systemGray3
        emailLabel.font = .systemFont(ofSize: 12)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailContainer.addSubview(emailLabel)
        
        emailField.placeholder = "Username"
        emailField.borderStyle = .roundedRect
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.addTarget(self, action: #selector(emailChanged), for: .editingChanged)
        emailContainer.addSubview(emailField)
        
        loginButton.setTitle("Log In", for: .normal)
        loginButton.backgroundColor = UIColor(red: 78.0 / 255.0, green: 83.0 / 255.0, blue: 162.0 / 255.0, alpha: 1.0)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        view.addSubview(loginButton)
        
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(.systemGray, for: .normal)
        signUpButton.titleLabel?.font = .systemFont(ofSize: 14)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(signUpButton)
    }
    
    private func setupPassword() {
        passwordContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(passwordContainer)
        
        passwordLabel.text = "Password"
        passwordLabel.textColor = .systemGray3
        passwordLabel.font = .systemFont(ofSize: 12)
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordContainer.addSubview(passwordLabel)
        
        passwordField.placeholder = "*********"
        passwordField.borderStyle = .roundedRect
        passwordField.isSecureTextEntry = true
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.addTarget(self, action: #selector(passwordChanged), for: .editingChanged)
        passwordContainer.addSubview(passwordField)
        
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.setTitleColor(.systemGray2, for: .normal)
        forgotPasswordButton.titleLabel?.font = .systemFont(ofSize: 12)
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        passwordContainer.addSubview(forgotPasswordButton)
        
        newToLabel.text = "New to StayConnected?"
        newToLabel.textColor = .systemGray3
        newToLabel.font = .systemFont(ofSize: 12)
        newToLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newToLabel)
        
        let eyeImage = UIImage(systemName: "eye.slash.fill")
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(eyeImage, for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        passwordField.rightView = eyeButton
        passwordField.rightViewMode = .always
        
        let lockImage = UIImage(systemName: "lock")
        let lockImageView = UIImageView(image: lockImage)
        lockImageView.tintColor = .gray
        lockImageView.contentMode = .scaleAspectFit
        passwordField.leftView = lockImageView
        passwordField.leftViewMode = .always
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 111),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            emailContainer.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 40),
            emailContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailContainer.widthAnchor.constraint(equalToConstant: 327),
            
            emailLabel.topAnchor.constraint(equalTo: emailContainer.topAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor),
            emailLabel.trailingAnchor.constraint(equalTo: emailContainer.trailingAnchor),
            
            emailField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailField.leadingAnchor.constraint(equalTo: emailContainer.leadingAnchor),
            emailField.trailingAnchor.constraint(equalTo: emailContainer.trailingAnchor),
            emailField.bottomAnchor.constraint(equalTo: emailContainer.bottomAnchor),
            
            passwordContainer.topAnchor.constraint(equalTo: emailContainer.bottomAnchor, constant: 40),
            passwordContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordContainer.widthAnchor.constraint(equalToConstant: 327),
            
            passwordLabel.topAnchor.constraint(equalTo: passwordContainer.topAnchor),
            passwordLabel.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor),
            
            passwordField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordField.leadingAnchor.constraint(equalTo: passwordContainer.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor),
            passwordField.bottomAnchor.constraint(equalTo: passwordContainer.bottomAnchor),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordContainer.topAnchor),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor),
            
            newToLabel.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 5),
            newToLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newToLabel.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor),
            
            signUpButton.trailingAnchor.constraint(equalTo: passwordContainer.trailingAnchor),
            signUpButton.centerYAnchor.constraint(equalTo: newToLabel.centerYAnchor),
            
            loginButton.topAnchor.constraint(equalTo: newToLabel.bottomAnchor, constant: 60),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 343),
            loginButton.heightAnchor.constraint(equalToConstant: 59)
        ])
    }
    
    @objc private func emailChanged(_ textField: UITextField) {
        viewModel.email = textField.text ?? ""
    }
    
    @objc private func passwordChanged(_ textField: UITextField) {
        viewModel.password = textField.text ?? ""
    }
    
    @objc private func loginTapped() {
        if viewModel.isValidEmail() && viewModel.isPasswordValid() {
            print("Login Successful")
        } else {
            print("Invalid email or password")
        }
    }
    
    @objc private func togglePasswordVisibility() {
        passwordField.isSecureTextEntry.toggle()
        
        let eyeImageName = passwordField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        
        if let eyeButton = passwordField.rightView as? UIButton {
            eyeButton.setImage(UIImage(systemName: eyeImageName), for: .normal)
        } else {
            print("Error: Eye button not initialized properly.")
        }
    }
}
