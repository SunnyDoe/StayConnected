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
    private let networkManager = NetworkManager()
    
    init() {
        setupObservers()
        fetchQuestions(for: currentQuestionType) 
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
            networkManager.fetchQuestions { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(QuestionListResponse.self, from: data)
                        self?.questions = response.questions
                    } catch {
                        print("Error decoding questions: \(error)")
                    }
                case .failure(let error):
                    print("Error fetching questions: \(error)")
                }
            }
        case .personal:
            networkManager.fetchQuestions { [weak self] result in
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode(QuestionListResponse.self, from: data)
                        self?.questions = response.questions
                    } catch {
                        print("Error decoding questions: \(error)")
                    }
                case .failure(let error):
                    print("Error fetching questions: \(error)")
                }
            }
        }
        
        isQuestionsEmpty = questions.isEmpty
    }

    func switchQuestionType(to type: QuestionType) {
        currentQuestionType = type
    }

    func addNewQuestion(_ question: Question) {
        questions.insert(question, at: 0)
        isQuestionsEmpty = questions.isEmpty
    }
}
