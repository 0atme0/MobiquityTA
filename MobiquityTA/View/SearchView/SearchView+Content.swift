//
//  SearchView+Content.swift
//  MobiquityTA
//
//  Created by atme on 19/09/2022.
//

import SwiftUI

extension SearchView {
    var content: some View {
        ZStack {
            searchContent
            if let error = viewmodel.showingError {
                errorView(error)
            }
        }
    }
}
