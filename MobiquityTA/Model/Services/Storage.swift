//
//  Storage.swift
//  MobiquityTA
//
//  Created by atme on 19/09/2022.
//

import SwiftUI

class Storage: ObservableObject {
    @AppStorage(Constants.Storage.K_SEARCH_HISTORY) var searchHistory: [String] = []

    func saveSearchText(_ text: String) {
        searchHistory.insert(text, at: 0)
    }

}
