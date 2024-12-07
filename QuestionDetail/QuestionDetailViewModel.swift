//
//  QuestionDetailViewModel.swift
//  StayConnected
//
//  Created by Imac on 07.12.24.
//


import Foundation
import Combine

class QuestionDetailViewModel {
    @Published var answer: [Answer] = []
    
    private var cancellables = Set<AnyCancellable>()
    private let networkManager = NetworkManager()
    private let question: Question
    
    init(question: Question) {
        self.question = question
    }


}
