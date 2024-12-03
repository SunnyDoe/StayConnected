//
//  NetworkManager.swift
//  StayConnected
//
//  Created by Sandro Tsitskishvili on 03.12.24.
//

import Foundation

class NetworkManager {
    private let registrationURL = "https://nunu29.pythonanywhere.com/users/register/"
    
    func registerUser(_ request: User, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: registrationURL) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonData = try JSONEncoder().encode(request)
            urlRequest.httpBody = jsonData
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                completion(.success(data))
            }
        }
        
        task.resume()
    }
}
