//
//  HomePageViewModel.swift
//  combineTest
//
//  Created by Imac on 29.11.24.
//


import Foundation
import Combine

class HomePageViewModel {
    @Published var questions: [Question] = []
    @Published var currentQuestionType: QuestionType = .general
    @Published var isQuestionsEmpty: Bool = true
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupObservers()
    }
    
    private func setupObservers() {
        $currentQuestionType
            .sink { [weak self] questionType in
                self?.fetchQuestions(for: questionType)
            }
            .store(in: &cancellables)
    }
    
    func fetchQuestions(for type: QuestionType) {
        switch type {
        case .general:
            questions = []
        case .personal:
            questions = []         }
        
        isQuestionsEmpty = questions.isEmpty
    }
    
    func switchQuestionType(to type: QuestionType) {
        currentQuestionType = type
    }
    
    func addNewQuestion(_ question: Question) {
        questions.append(question)
        isQuestionsEmpty = questions.isEmpty
    }
}
