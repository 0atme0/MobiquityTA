//
//  SearchViewModel.swift
//  MobiquityTA
//
//  Created by atme on 19/09/2022.
//

import SwiftUI
import Combine

protocol SearchViewModelProtocol: ObservableObject {
    func search(_ text: String)
    func fetchNewPage()
    var photos: [Photo] {get}
}

class SearchViewModel: SearchViewModelProtocol {
    
    let searchWorker: SearchWorkerProtocol
    let storage: any StorageProtocol
    @Published var photos: [Photo] = []
    @Published var showingError: String?
    @Published var currentPage = 0
    @Published var photosListFull = false
    @Published var currentSearchText = ""
    let perPage = 20
    
    init(searchWorker: SearchWorkerProtocol = SearchWorker(), storage: any StorageProtocol = Storage()) {
        self.searchWorker = searchWorker
        self.storage = storage
    }
    
    //MARK: - Public methods
    
    /// Sends SearchByKeyword request and updates photos
    /// - Parameter text: from search bar
    func search(_ text: String) {
        self.currentSearchText = text
        storage.saveSearchText(text)
        searchWorker.searchByKeyword(keyword: text, perPage: perPage, pageNumber: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self?.photos = photos
                    // If count of data received is less than perPage value then it is last page.
                    if photos.count < self?.perPage ?? 0 {
                        self?.photosListFull = true
                    }
                case .failure(let error):
                    self?.showingError = error.localizedDescription
                }
            }
        }
    }
    
    /// Fetches next page for searchByKeyword
    func fetchNewPage() {
        self.currentPage += 1
        searchWorker.searchByKeyword(keyword: currentSearchText, perPage: perPage, pageNumber: currentPage) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let photos):
                    self?.photos.append(contentsOf: photos)
                    // If count of data received is less than perPage value then it is last page.
                    if photos.count < self?.perPage ?? 0 {
                        self?.photosListFull = true
                    }
                case .failure(let error):
                    self?.showingError = error.localizedDescription
                }
            }
        }
    }
    
}
