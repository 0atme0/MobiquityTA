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
    
    let network: Network
    
    init(network: Network = Network()) {
        self.network = network
    }
    
    func searchByKeyword(keyword: String, pageNumber : Int, completion: @escaping SearchResultHandler) {
        let parameters: [String: String] = [
            "method": Constants.SEARCH_BY_KEYWORD,
            "api_key": Constants.API_KEY,
            "text": keyword,
            "per_page": "20",
            "page": "\(pageNumber)",
            "format": "json",
            "nojsoncallback": "1"
        ]
        network.sendRequest(Constants.WEBSERVICE_BASE_URL, parameters: parameters) { responseObject, error in
            guard let responseObject = responseObject, error == nil else {
                print(error ?? "Unknown error")
                return
            }
            
            // use `responseObject` here
        }
    }
}
