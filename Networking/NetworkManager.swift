//
//  NetworkManager.swift
//  StayConnected
//
//  Created by Sandro Tsitskishvili on 03.12.24.
//

import Foundation

class NetworkManager {
    
    func registerUser(_ user: User, completion: @escaping (Result<SignUpResponse, Error>) -> Void) {
        guard let url = URL(string: "https://nunu29.pythonanywhere.com/users/register/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let requestBody = try JSONEncoder().encode(user)
            request.httpBody = requestBody
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            do {
                let signUpResponse = try JSONDecoder().decode(SignUpResponse.self, from: data)
                completion(.success(signUpResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    
    func loginUser(_ authModel: AuthModel, completion: @escaping (Result<SignUpResponse, Error>) -> Void) {
        guard let url = URL(string: "https://nunu29.pythonanywhere.com/users/login/") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let requestBody = try JSONEncoder().encode(authModel)
            request.httpBody = requestBody
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let authResponse = try JSONDecoder().decode(SignUpResponse.self, from: data)
                completion(.success(authResponse))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchQuestions(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "https://nunu29.pythonanywhere.com/questions/questions_list/") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: 0, userInfo: nil)))
                return
            }

            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw response data: \(responseString)")
            }
            
            completion(.success(data))
        }.resume()
    }

    func addQuestion(_ question: Question, completion: @escaping (Result<Question, Error>) -> Void) {
        guard let url = URL(string: "https://nunu29.pythonanywhere.com/questions/questions_create/") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let requestBody = try JSONEncoder().encode(question)
            request.httpBody = requestBody
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let createdQuestion = try JSONDecoder().decode(Question.self, from: data)
                completion(.success(createdQuestion))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }


}
