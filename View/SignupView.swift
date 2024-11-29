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
    
    private let fullNameLabel = UILabel()
    private let emailLabel = UILabel()
    private let passwordLabel = UILabel()
    private let confirmPasswordLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = "Sign up"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        configureTextField(fullNameTextField, placeholder: "Name", tag: 0)
        configureTextField(emailTextField, placeholder: "Username", tag: 1)
        configureTextField(passwordTextField, placeholder: "********", isSecure: true, tag: 2)
        configureTextField(confirmPasswordTextField, placeholder: "********", isSecure: true, tag: 3)

        setupLabel(fullNameLabel, text: "Full Name")
        setupLabel(emailLabel, text: "Email")
        setupLabel(passwordLabel, text: "Enter Password")
        setupLabel(confirmPasswordLabel, text: "Confirm Password")

        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = UIColor(red: 78.0 / 255.0, green: 83.0 / 255.0, blue: 162.0 / 255.0, alpha: 1.0)
        signUpButton.setTitleColor(.white, for: .normal)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        view.addSubview(signUpButton)

        statusLabel.textColor = .red
        statusLabel.font = UIFont.systemFont(ofSize: 14)
        statusLabel.numberOfLines = 0
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(statusLabel)

        let stackView = UIStackView(arrangedSubviews: [
            fullNameLabel, fullNameTextField,
            emailLabel, emailTextField,
            passwordLabel, passwordTextField,
            confirmPasswordLabel, confirmPasswordTextField
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            signUpButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 40),
            signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),

            statusLabel.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 16),
            statusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])

        addLockAndEyeIcons(to: passwordTextField)
        addLockAndEyeIcons(to: confirmPasswordTextField)
    }
    
    private func addLockAndEyeIcons(to textField: UITextField) {
        let lockImage = UIImage(systemName: "lock")
        let lockImageView = UIImageView(image: lockImage)
        lockImageView.tintColor = .gray
        lockImageView.contentMode = .scaleAspectFit
        textField.leftView = lockImageView
        textField.leftViewMode = .always
        
        let eyeImage = UIImage(systemName: "eye.slash.fill")
        let eyeButton = UIButton(type: .custom)
        eyeButton.setImage(eyeImage, for: .normal)
        eyeButton.tintColor = .gray
        eyeButton.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        textField.rightView = eyeButton
        textField.rightViewMode = .always
    }
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        if let textField = sender.superview as? UITextField {
            textField.isSecureTextEntry.toggle()

            let eyeImageName = textField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
            sender.setImage(UIImage(systemName: eyeImageName), for: .normal)
        }
    }

    private func setupLabel(_ label: UILabel, text: String) {
        label.text = text
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
    }
    
    private func configureTextField(_ textField: UITextField, placeholder: String, isSecure: Bool = false, tag: Int) {
        textField.placeholder = placeholder
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = isSecure
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = tag
        textField.delegate = self
        view.addSubview(textField)

        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalToConstant: 327),
            textField.heightAnchor.constraint(equalToConstant: 52)
        ])
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
    }
}



