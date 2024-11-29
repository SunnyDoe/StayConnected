//
//  AuthViewModel.swift
//  StayConnected
//
//  Created by Sandro Tsitskishvili on 28.11.24.
//

class AuthViewModel {
    var email: String = ""
    var password: String = ""
    
    func isValidEmail() -> Bool {
        return email.contains("@")
    }
    
    func isPasswordValid() -> Bool {
        return password.count >= 6
    }
}
