//
//  HomePageModel.swift
//  combineTest
//
//  Created by Imac on 29.11.24.
//

import Foundation

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
