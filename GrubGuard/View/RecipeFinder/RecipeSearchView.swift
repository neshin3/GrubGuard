//
//  RecipeSearchView.swift
//  GrubGuard
//
//  Created by Nestor on 4/27/25.
//

import SwiftUI
import FirebaseAuth

struct RecipeSearchView: View {
    @StateObject private var viewModel = RecipeViewModel()
    @State private var searchTags = "vegan"
    @State private var numberOfResults = 1
    @State private var shouldNavigate = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                TextField("Enter tags (e.g., vegetarian, dessert)", text: $searchTags)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)

                Stepper("Number of Recipes: \(numberOfResults)", value: $numberOfResults, in: 1...20)
                    .padding(.horizontal)

                Button(action: {
                    Task {
                        let cleanedSearchTags = searchTags.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

                        print("Search Tags: \(cleanedSearchTags)")

                        await viewModel.fetchRecipes(tags: cleanedSearchTags, number: numberOfResults)

                        if !viewModel.recipes.isEmpty {
                            for recipe in viewModel.recipes {
                                print("Recipe ID: \(recipe.id)")
                            }
                            shouldNavigate = true
                        }
                    }
                }) {
                    Text("Search Recipes")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(searchTags.isEmpty ? Color.gray : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                .disabled(searchTags.isEmpty)
                
                if viewModel.isLoading {
                    ProgressView("Loading Recipes...")
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                Button("Sign Out") {
                    do {
                        try Auth.auth().signOut()
                    } catch let error {
                        print("Sign out error: \(error.localizedDescription)")
                    }
                }
                .foregroundColor(.red)
                .padding()
                
            }
            .navigationTitle("Search Recipes")
            .navigationDestination(isPresented: $shouldNavigate) {
                RecipeFinderView(recipes: viewModel.recipes)
            }
        }
    }
}

#Preview {
    RecipeSearchView()
}
