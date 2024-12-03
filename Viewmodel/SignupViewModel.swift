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
    
    
    
    func signUp(completion: (Bool, String) -> Void) {
        if isSignUpEnabled {
            completion(true, "Sign up successful!")
        } else {
            completion(false, "Please fill all fields correctly.")
        }
    }
}
