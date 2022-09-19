//
//  Parser.swift
//  MobiquityTA
//
//  Created by atme on 19/09/2022.
//

import Foundation

class Parser {
    let decoder = JSONDecoder()
    
    func photoSearch(json: Data) -> SearchResult {
        let decoder = JSONDecoder()
        do {
            let jsonPhotos = try decoder.decode(PhotoResponse.self, from: json)
            return .success(jsonPhotos.photos.photo)
        } catch {
            return .failure(error)
        }
    }
}
