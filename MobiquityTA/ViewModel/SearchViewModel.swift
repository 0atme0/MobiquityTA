//
//  SearchViewModel.swift
//  MobiquityTA
//
//  Created by atme on 19/09/2022.
//

import Foundation

class SearchViewModel: ObservableObject {
    let searchWorker: SearchWorker
    
    init(searchWorker: SearchWorker = SearchWorker()) {
        self.searchWorker = searchWorker
    }
    
    func search(_ text: String) {
        searchWorker.searchByKeyword(keyword: text, pageNumber: 1) { result in
            
        }
    }
}
