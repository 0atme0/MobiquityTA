//
//  SearchView.swift
//  MobiquityTA
//
//  Created by atme on 14/09/2022.
//

import SwiftUI

struct SearchView: View {
    @State var searchText: String = ""
    @State private var searchHistory = ["First", "Second", "Third"]
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
                    }
                }
                .searchable(text: $searchText, prompt: "Look for something") {
                    ForEach(searchHistory, id: \.self) {
                        Text($0.capitalized)
                    }
                }
                .navigationTitle("Flickr Image Search")
            }
            .onSubmit(of: .search, runSearch)
            Spacer()
        }
    }
    
    func runSearch() {
        print(#function)
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
