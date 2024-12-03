//
//  SignUpModel.swift
//  StayConnected
//
//  Created by Sandro Tsitskishvili on 29.11.24.
//

import Foundation

struct User: Codable {
    let email: String
    let password: String
    let confirm_password: String
    let full_name: String
}
