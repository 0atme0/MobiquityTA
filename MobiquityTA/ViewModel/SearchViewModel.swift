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
    
    let searchWorker: SearchWorker
    let storage: Storage
    @Published var photos: [Photo] = []
    @Published var showingError: String?
    @Published var currentPage = 0
    @Published var photosListFull = false
    @Published var currentSearchText = ""
    let perPage = 20

    init(searchWorker: SearchWorker = SearchWorker(), storage: Storage = Storage()) {
        self.searchWorker = searchWorker
        self.storage = storage
    }
    
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
