//
//  SearchView+ErrorView.swift
//  MobiquityTA
//
//  Created by atme on 19/09/2022.
//

import SwiftUI

extension SearchView {
    func errorView(_ text: String) -> some View {
        VStack {
            Spacer()
            Text(text)
                .padding()
        }
    }
}
