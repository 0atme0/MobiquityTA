//
//  SearchWorker.swift
//  MobiquityTA
//
//  Created by atme on 19/09/2022.
//

import Foundation

typealias SearchResult = Result<[Photo], Error>
typealias SearchResultHandler = (SearchResult)->()

class SearchWorker {
    
    private let network: Network
    private let parser: Parser
    
    init(network: Network = Network(), parser: Parser = Parser()) {
        self.network = network
        self.parser = parser
    }
    
    func searchByKeyword(keyword: String, perPage: Int, pageNumber : Int, completion: @escaping SearchResultHandler) {
        let parameters: [String: String] = [
            "method": Constants.SEARCH_BY_KEYWORD,
            "api_key": Constants.API_KEY,
            "text": keyword,
            "per_page": "\(perPage)",
            "page": "\(pageNumber)",
            "format": "json",
            "nojsoncallback": "1"
        ]
        network.sendRequest(Constants.WEBSERVICE_BASE_URL, parameters: parameters) { result in
            switch result {
            case .success(let data):
                let parsedValue = self.parser.photoSearch(json: data)
                completion(parsedValue)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
