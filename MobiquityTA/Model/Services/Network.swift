//
//  Network.swift
//  MobiquityTA
//
//  Created by atme on 19/09/2022.
//

import Foundation

typealias NetworkResult = Result<Data, Error>
typealias NetworkResultHandler = (NetworkResult)->()

protocol NetworkProtocol {
    func sendRequest(_ url: String, parameters: [String: String], completion: @escaping NetworkResultHandler)
}

class Network: NetworkProtocol {
    
    //MARK: - Public methods
    
    /// sends network requests
    /// - Parameters:
    ///   - url: url string
    ///   - parameters: parameters of url request
    ///   - completion: returns response
    public func sendRequest(_ url: String, parameters: [String: String], completion: @escaping NetworkResultHandler) {
        var components = URLComponents(string: url)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        let request = URLRequest(url: components.url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let response = response as? HTTPURLResponse,
                200 ..< 300 ~= response.statusCode,
                error == nil
            else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
}
