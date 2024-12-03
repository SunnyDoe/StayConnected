//
//  SignupViewModel.swift
//  StayConnected
//
//  Created by Sandro Tsitskishvili on 29.11.24.
//

import Foundation

class SignUpViewModel {
    var fullName: String = ""
    var email: String = ""
    var password: String = ""
    var confirmPassword: String = ""
    
    var isSignUpEnabled: Bool {
        return !fullName.isEmpty &&
        !email.isEmpty &&
        !password.isEmpty &&
        password == confirmPassword
    }
    
    private let networkManager = NetworkManager()
    
    func signUp(completion: @escaping (Bool, String) -> Void) {
        guard isSignUpEnabled else {
            completion(false, "Please fill all fields correctly.")
            return
        }
        
        let request = User(
            email: email,
            password: password,
            confirm_password: confirmPassword,
            full_name: fullName
        )
        
        networkManager.registerUser(request) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    completion(true, "Sign up successful!")
                case .failure(let error):
                    completion(false, "Failed to sign up: \(error.localizedDescription)")
                }
            }
        }
    }
}
