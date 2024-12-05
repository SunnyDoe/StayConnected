//
//  AuthViewModel.swift
//  StayConnected
//
//  Created by Sandro Tsitskishvili on 28.11.24.
//

import Foundation

class LoginViewModel {
    private let networkManager = NetworkManager()
    
    var email: String = ""
    var password: String = ""
    
    var onStatusUpdate: ((String, Bool) -> Void)?
    var onCompletion: (() -> Void)?
    
    func signIn() {
        guard isValidEmail(), isPasswordValid() else {
            onStatusUpdate?("Invalid email or password", false)
            return
        }
        
        let authModel = AuthModel(email: email, password: password)
        
        let networkManager = NetworkManager()
        networkManager.loginUser(authModel) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self?.onStatusUpdate?("Login successful", true)
                    self?.onCompletion?()  
                case .failure(let error):
                    self?.onStatusUpdate?("Error: \(error.localizedDescription)", false)
                }
            }
        }
    }
    
    func isValidEmail() -> Bool {
        return email.contains("@")
    }
    
    func isPasswordValid() -> Bool {
        return password.count >= 6
    }
}

