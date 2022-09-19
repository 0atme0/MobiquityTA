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
        content
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewmodel: SearchViewModel())
    }
}
