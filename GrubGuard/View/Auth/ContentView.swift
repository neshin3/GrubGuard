//
//  ContentView.swift
//  GrubGuard
//
//  Created by Nestor on 4/8/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = UserAuthViewModel()

    var body: some View {
        NavigationStack {
            if viewModel.isUserSignedIn {
                RecipeSearchView()
            } else {
                AuthView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    ContentView()
}
