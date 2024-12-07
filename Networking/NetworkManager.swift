//
//  NetworkManager.swift
//  StayConnected
//
//  Created by Sandro Tsitskishvili on 03.12.24.
//

import Foundation
import Combine
enum NetworkError: Error {
    case invalidURL
    case requestFailed(statusCode: Int)
    case decodingError
    case unknownError
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .requestFailed(let statusCode):
            return "Request failed with status code: \(statusCode)"
        case .decodingError:
            return "Unable to decode the response"
        case .unknownError:
            return "An unknown error occurred"
        }
    }
}

class NetworkManager {
    private let baseURL = URL(string: "https://nunu29.pythonanywhere.com/questions/questions_answers_create/")!
    
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
    
    func sendQuestion(_ questionText: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "https://nunu29.pythonanywhere.com/questions/questions_answers_create/") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters: [String: String] = ["body": questionText]

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }

        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                completion(.failure(NetworkError.requestFailed(statusCode: (response as? HTTPURLResponse)?.statusCode ?? -1)))
                return
            }

            completion(.success(()))
        }.resume()
    }

    func sendQuestion(questionText: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let url = URL(string: "https://nunu29.pythonanywhere.com/questions/questions_answers_create/") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = ["body": questionText]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            completion(.success(()))
        }.resume()
    }

    func fetchAnswer(completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "https://nunu29.pythonanywhere.com/questions/questions_retrieve/") else {
            completion(.failure(NetworkError.invalidURL))
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
                completion(.failure(NetworkError.unknownError))
                return
            }
            
            do {
                let responseDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let answer = responseDict?["answer"] as? String {
                    completion(.success(answer))
                } else {
                    completion(.failure(NetworkError.decodingError))
                }
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

}
