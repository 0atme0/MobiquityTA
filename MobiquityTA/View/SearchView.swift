//
//  SearchView.swift
//  MobiquityTA
//
//  Created by atme on 14/09/2022.
//

import SwiftUI

struct SearchView: View {
    
    @State var searchText: String = ""
    @State private var selection: String = ""
    var grid = [GridItem(.flexible()), GridItem(.flexible())]
    @ObservedObject var viewmodel: SearchViewModel
    
    var body: some View {
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
    
    func runSearch() {
        Task {
            viewmodel.search(searchText)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewmodel: SearchViewModel())
    }
}
