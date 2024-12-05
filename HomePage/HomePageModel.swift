//
//  HomePageModel.swift
//  combineTest
//
//  Created by Imac on 29.11.24.
//

import Foundation

enum QuestionType {
    case general
    case personal
}

struct Question {
    let id: UUID
    let title: String
    let type: QuestionType
}
