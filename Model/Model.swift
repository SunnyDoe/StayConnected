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

struct AuthModel: Codable {
    var username: String
    var password: String
}

enum QuestionType: String, Codable {
    case general
    case personal
}

struct QuestionListResponse: Codable {
    let questions: [Question]
    
}

struct Question: Codable {
    let id: Int?
    let user: String
    let subject: String
    let body: String
    let tagDetails: [Tag]
    let likeCount: Int
    let numberOfAnswers: Int
    let createdAt: String
}

struct Tag: Codable {
    let name: String
}

struct AddQuestionResponse: Codable {
    let status: String
}

struct Answer: Codable {
    let id: Int?
    let user: String
    let subject: String
    let body: String
    let tagDetails: [Tag]
    let likeCount: Int
    let createdAt: String
}




struct AddAnswernResponse: Codable {
    let status: String
}

struct QuestionDetail: Codable {
    let id: Int
    let subject: String
    let body: String
    let answers: [Answer]
}
