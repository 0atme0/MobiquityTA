//
//  SearchViewModel.swift
//  MobiquityTA
//
//  Created by atme on 19/09/2022.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    let searchWorker: SearchWorker
    @Published var photos: [Photo] = []
    @Published var showingError: String?
    @Published var currentPage = 0
    @Published var membersListFull = false
    let perPage = 20

    init(searchWorker: SearchWorker = SearchWorker()) {
        self.searchWorker = searchWorker
    }
    
    func search(_ text: String) {
        searchWorker.searchByKeyword(keyword: text, perPage: perPage, pageNumber: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self?.currentPage += 1
                    self?.photos.append(contentsOf: photos)
                    // If count of data received is less than perPage value then it is last page.
                    if photos.count < self?.perPage ?? 0 {
                          self?.membersListFull = true
                      }
                case .failure(let error):
                    self?.showingError = error.localizedDescription
                }
            }
        }
    }
    
    
}
