//
//  SearchView.swift
//  MobiquityTA
//
//  Created by atme on 14/09/2022.
//

import SwiftUI

struct SearchResultItem: Identifiable, Codable {
    var id = UUID()
    var url = "http://farm1.static.flickr.com/578/23451156376_8983a8ebc7.jpg"
}
struct SearchView: View {
    @State var searchText: String = ""
    @State private var searchResults = [SearchResultItem(), SearchResultItem(), SearchResultItem(), SearchResultItem()]
    @State private var searchHistory = ["First", "Second", "Third"]
    @State private var selection: String = ""
    var grid = [GridItem(.flexible()), GridItem(.flexible())]
    @ObservedObject var viewmodel: SearchViewModel
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: grid) {
                        ForEach(searchResults, id: \.id) {
                            AsyncImage(url: URL(string: $0.url)) { phase in
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
        .onAppear {
            viewmodel.search("wolf")
        }
    }
    
    func runSearch() {
        print(#function)
        Task {
            guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=28173ef65bf686a47baddfd9e3c147b3&text=\(searchText)&page=1&format=json&nojsoncallback=1&auth_token=72157720857177174-eab6545cff51b2af&api_sig=25786642e722e1c184408924b1b5617a") else { return }
            print(#function, url)
            let (data, _) = try await URLSession.shared.data(from: url)
            searchResults = try JSONDecoder().decode([SearchResultItem].self, from: data)
            print(#function, url, searchResults)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewmodel: SearchViewModel())
    }
}
