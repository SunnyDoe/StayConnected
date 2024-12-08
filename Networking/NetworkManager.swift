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
            print("Invalid URL")
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
            print("Request body: \(String(data: jsonData, encoding: .utf8) ?? "Failed to encode request body")")
        } catch {
            print("Error serializing JSON: \(error)")
            completion(.failure(error))
            return
        }

        print("Sending request to URL: \(url)")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error occurred: \(error)")
                return completion(.failure(error))
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response: \(String(describing: response))")
                completion(.failure(NetworkError.requestFailed(statusCode: -1)))
                return
            }

            print("HTTP response status code: \(httpResponse.statusCode)")

            switch httpResponse.statusCode {
            case 200...299:
                print("Request successful. Status code: \(httpResponse.statusCode)")
                completion(.success(()))
            case 400:
                print("Client error - Bad Request (400). Check request payload and parameters.")
                if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
                completion(.failure(NetworkError.requestFailed(statusCode: httpResponse.statusCode)))
            case 401:
                print("Client error - Unauthorized (401). Check authentication credentials.")
                if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
                completion(.failure(NetworkError.requestFailed(statusCode: httpResponse.statusCode)))
            case 403:
                print("Client error - Forbidden (403). Access is denied.")
                if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
                completion(.failure(NetworkError.requestFailed(statusCode: httpResponse.statusCode)))
            case 404:
                print("Client error - Not Found (404). The resource could not be found.")
                if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
                completion(.failure(NetworkError.requestFailed(statusCode: httpResponse.statusCode)))
            case 500:
                print("Server error - Internal Server Error (500). The server encountered an error.")
                if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
                completion(.failure(NetworkError.requestFailed(statusCode: httpResponse.statusCode)))
            case 502:
                print("Server error - Bad Gateway (502). The server received an invalid response from the upstream server.")
                if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
                completion(.failure(NetworkError.requestFailed(statusCode: httpResponse.statusCode)))
            case 503:
                print("Server error - Service Unavailable (503). The server is currently unable to handle the request.")
                if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
                completion(.failure(NetworkError.requestFailed(statusCode: httpResponse.statusCode)))
            default:
                print("Unexpected status code: \(httpResponse.statusCode).")
                if let responseData = data, let responseString = String(data: responseData, encoding: .utf8) {
                    print("Response data: \(responseString)")
                }
                completion(.failure(NetworkError.requestFailed(statusCode: httpResponse.statusCode)))
            }
        }.resume()
    }

    func sendAnswer(questionId: Int, answerText: String, completion: @escaping (Result<Answer, Error>) -> Void) {
            guard let url = URL(string: "http://164.90.230.102/api/questions/{question_id}/answers/") else {
                completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let parameters: [String: Any] = [
                "question": questionId,
                "body": answerText
            ]
            
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = jsonData
            } catch {
                completion(.failure(error))
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Request error: \(error)")
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid response type")
                    completion(.failure(NSError(domain: "InvalidResponse", code: 0, userInfo: nil)))
                    return
                }
                
                print("HTTP Status Code: \(httpResponse.statusCode)")
                
                if (200...299).contains(httpResponse.statusCode) {
                    guard let data = data else {
                        completion(.failure(NSError(domain: "DataError", code: 0, userInfo: nil)))
                        return
                    }
                    
                    do {
                        let createdAnswer = try JSONDecoder().decode(Answer.self, from: data)
                        completion(.success(createdAnswer))
                    } catch {
                        print("Error decoding answer: \(error)")
                        completion(.failure(error))
                    }
                } else {
                    switch httpResponse.statusCode {
                    case 400:
                        print("Bad Request (400): The server could not understand the request due to invalid syntax.")
                    case 401:
                        print("Unauthorized (401): Authentication is required and has failed or has not been provided.")
                    case 403:
                        print("Forbidden (403): The server understands the request but refuses to authorize it.")
                    case 404:
                        print("Not Found (404): The server could not find the requested resource.")
                    case 500:
                        print("Internal Server Error (500): The server has encountered a situation it doesn't know how to handle.")
                    case 503:
                        print("Service Unavailable (503): The server is not ready to handle the request, possibly due to being overloaded or down for maintenance.")
                    default:
                        print("HTTP Error (\(httpResponse.statusCode)): \(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
                    }
                    
                    if let data = data, let errorString = String(data: data, encoding: .utf8) {
                        print("Error response body: \(errorString)")
                    }
                    
                    completion(.failure(NSError(domain: "HTTPError", code: httpResponse.statusCode, userInfo: nil)))
                }
            }.resume()
        }
     
        func fetchSpecificQuestionAnswers(questionId: Int, completion: @escaping (Result<[Answer], Error>) -> Void) {
            guard let url = URL(string: "http://164.90.230.102/api/questions/{question_id}/answers/") else {
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
                    print("Raw specific question answers response: \(responseString)")
                }
                
                do {
                    let questionDetail = try JSONDecoder().decode(QuestionDetail.self, from: data)
                    completion(.success(questionDetail.answers))
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(error))
                }
            }.resume()
        }
}
