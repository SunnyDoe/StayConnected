//
//  QuestionDetailViewModel.swift
//  StayConnected
//
//  Created by Imac on 07.12.24.
//


import Foundation
import Combine

class QuestionDetailViewModel {
    @Published var answers: [Answer] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    private let networkManager = NetworkManager()
    private let question: Question
    
    init(question: Question) {
        self.question = question
    }
    
    func fetchAnswers() {
        guard let questionId = question.id else { return }
        
        isLoading = true
        
        networkManager.fetchSpecificQuestionAnswers(questionId: questionId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let answers):
                    self?.answers = answers
                case .failure(let error):
                    self?.error = error
                    print("Error fetching answers: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func sendAnswer(_ answerText: String, completion: @escaping (Bool) -> Void) {
        guard let questionId = question.id else {
            completion(false)
            return
        }
        
        networkManager.sendAnswer(questionId: questionId, answerText: answerText) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let answer):
                    self?.answers.append(answer)
                    completion(true)
                case .failure(let error):
                    print("Failed to send answer: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }
}
