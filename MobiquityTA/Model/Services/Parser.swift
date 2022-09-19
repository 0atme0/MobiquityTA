//
//  Parser.swift
//  MobiquityTA
//
//  Created by atme on 19/09/2022.
//

import Foundation

protocol ParserProtocol {
    func photoSearch(json: Data) -> SearchResult
}

class Parser: ParserProtocol {
    private let decoder = JSONDecoder()
    
    public func photoSearch(json: Data) -> SearchResult {
        let decoder = JSONDecoder()
        do {
            let jsonPhotos = try decoder.decode(PhotoResponse.self, from: json)
            return .success(jsonPhotos.photos.photo)
        } catch {
            return .failure(error)
        }
    }
}
