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
        print("QuestionDetailViewModel initialized with question ID: \(String(describing: question.id))")
    }
    
    func fetchAnswers() {
        guard let questionId = question.id else {
            print("Cannot fetch answers: Question ID is nil")
            return
        }
        
        isLoading = true
        print("Fetching answers for question ID: \(questionId)")
        
        networkManager.fetchSpecificQuestionAnswers(questionId: questionId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let answers):
                    print("Successfully fetched \(answers.count) answers")
                    self?.answers = answers
                case .failure(let error):
                    print("Error fetching answers: \(error.localizedDescription)")
                    self?.error = error
                }
            }
        }
    }
    
    func sendAnswer(_ answerText: String, completion: @escaping (Bool) -> Void) {
        print("Attempting to send answer: \(answerText)")
        
        guard let questionId = question.id else {
            print("Cannot send answer: Question ID is nil")
            completion(false)
            return
        }
        
        print("Sending answer for question ID: \(questionId)")
        
        networkManager.sendAnswer(questionId: questionId, answerText: answerText) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let answer):
                    print("Answer sent successfully: \(answer)")
                    self?.answers.append(answer)
                    completion(true)
                case .failure(let error):
                    print("Failed to send answer. Error: \(error.localizedDescription)")
                    completion(false)
                }
            }
        }
    }
}
