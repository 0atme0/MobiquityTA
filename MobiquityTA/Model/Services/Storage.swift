//
//  Storage.swift
//  MobiquityTA
//
//  Created by atme on 19/09/2022.
//

import SwiftUI

protocol StorageProtocol: ObservableObject {
    var searchHistory: [String] {get}
    func saveSearchText(_ text: String)
}

class Storage: StorageProtocol {
    @AppStorage(Constants.Storage.K_SEARCH_HISTORY) var searchHistory: [String] = []
    
    //MARK: - Public methods
    
    /// saves a search text
    /// - Parameter text: search text
    func saveSearchText(_ text: String) {
        guard !text.isEmpty else {return}
        searchHistory.insert(text, at: 0)
    }

}
