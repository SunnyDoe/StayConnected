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
    let username: String
}

struct SignUpResponse: Codable {
    let user: UserDetails
    let tokens: Tokens
}

struct UserDetails: Codable {
    let id: Int
    let username: String
    let email: String
}

struct Tokens: Codable {
    let refresh: String
    let access: String
}

struct AuthModel {
    var email: String
    var password: String
}
