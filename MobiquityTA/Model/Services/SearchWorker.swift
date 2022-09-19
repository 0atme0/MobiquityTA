//
//  SearchWorker.swift
//  MobiquityTA
//
//  Created by atme on 19/09/2022.
//

import Foundation

typealias SearchResult = Result<[Photo], Error>
typealias SearchResultHandler = (SearchResult)->()

protocol SearchWorkerProtocol {
    func searchByKeyword(keyword: String, perPage: Int, pageNumber : Int, completion: @escaping SearchResultHandler)
}

class SearchWorker: SearchWorkerProtocol {
    
    private let network: NetworkProtocol
    private let parser: ParserProtocol
    
    init(network: NetworkProtocol = Network(), parser: ParserProtocol = Parser()) {
        self.network = network
        self.parser = parser
    }
    
    public func searchByKeyword(keyword: String, perPage: Int, pageNumber : Int, completion: @escaping SearchResultHandler) {
        let parameters: [String: String] = [
            "method": Constants.Network.SEARCH_BY_KEYWORD,
            "api_key": Constants.Network.API_KEY,
            "text": keyword,
            "per_page": "\(perPage)",
            "page": "\(pageNumber)",
            "format": "json",
            "nojsoncallback": "1"
        ]
        network.sendRequest(Constants.Network.WEBSERVICE_BASE_URL, parameters: parameters) { result in
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
