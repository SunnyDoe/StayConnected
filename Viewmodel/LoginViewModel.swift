//
//  AuthViewModel.swift
//  StayConnected
//
//  Created by Sandro Tsitskishvili on 28.11.24.
//

import Foundation

class LoginViewModel {
    private let networkManager = NetworkManager()
    
    var username: String = ""
    var password: String = ""
    
    var onStatusUpdate: ((String, Bool) -> Void)?
    var onCompletion: (() -> Void)?
    
    func signIn() {
        guard isValidUsername(), isPasswordValid() else {
            onStatusUpdate?("Invalid email or password", false)
            return
        }
        
        let authModel = AuthModel(username: username, password: password)

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
    
    private func storeTokens(tokens: Tokens) {
        Keychain.shared.save("accessToken", value: tokens.access)
        Keychain.shared.save("refreshToken", value: tokens.refresh)
    }
    
    func isValidUsername() -> Bool {
        return username.count >= 1
    }
    
    func isPasswordValid() -> Bool {
        return password.count <= 50
    }
}

