//
//  SearchView+SearchContent.swift
//  MobiquityTA
//
//  Created by atme on 19/09/2022.
//

import SwiftUI

extension SearchView {
    var searchContent: some View {
        VStack {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: grid) {
                        ForEach(viewmodel.photos, id: \.id) {
                            AsyncImage(url: $0.photoURL) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 300, maxHeight: 100)
                                case .failure:
                                    Image(systemName: "photo")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        }
                        if viewmodel.photosListFull == false && viewmodel.photos.count > 0 {
                            ProgressView()
                                .onAppear {
                                    viewmodel.fetchNewPage()
                                }
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Look for something") {
                    ForEach(viewmodel.storage.searchHistory, id: \.self) { item in
                        Text(item.capitalized).searchCompletion(item)
                    }
                }
                .navigationTitle("Flickr Image Search")
            }
            .onSubmit(of: .search, runSearch)
            Spacer()
        }
    }
}

extension SearchView {
    func runSearch() {
        Task {
            viewmodel.search(searchText)
        }
    }
}
