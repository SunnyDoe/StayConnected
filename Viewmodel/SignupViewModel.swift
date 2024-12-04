//
//  SignupViewModel.swift
//  StayConnected
//
//  Created by Sandro Tsitskishvili on 29.11.24.
//

import Foundation

class SignUpViewModel {
    private let networkManager = NetworkManager()
    var userName: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    var isSignUpEnabled: Bool {
        return !userName.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        isValidEmail(email) &&
        password == confirmPassword
    }
    
    var emailErrorMessage: String? {
        return isValidEmail(email) ? nil : "Please enter a valid email address."
    }
    
    var onStatusUpdate: ((String, Bool) -> Void)?
    var onCompletion: (() -> Void)?
    
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    
    func signUp() {
            guard isSignUpEnabled else {
                onStatusUpdate?("Please fill all fields correctly.", false)
                return
            }
            
        let request = User(email: email, password: password, confirm_password: confirmPassword, username: userName)
            
            networkManager.registerUser(request) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        self?.storeTokens(tokens: response.tokens)
                        self?.onStatusUpdate?("Welcome, \(response.user.username)!", true)
                        self?.onCompletion?()
                    case .failure(let error):
                        self?.onStatusUpdate?("Failed to sign up: \(error.localizedDescription)", false)
                    }
                }
            }
        }
        
        private func storeTokens(tokens: Tokens) {
            Keychain.shared.save("accessToken", value: tokens.access)
            Keychain.shared.save("refreshToken", value: tokens.refresh)
        }
    }
