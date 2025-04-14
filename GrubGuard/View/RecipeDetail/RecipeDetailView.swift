//
//  RecipeDetailView.swift
//  GrubGuard
//
//  Created by Nestor on 4/16/25.
//

import SwiftUI

struct RecipeDetailView: View {
    let recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: recipe.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipped()
                } placeholder: {
                    ProgressView()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(recipe.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)

                    HStack {
                        Label("\(recipe.readyInMinutes) mins", systemImage: "clock")
                        Spacer()
                        Label("Serves \(recipe.servings)", systemImage: "person.3.fill")
                    }
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    
                    Divider()
                    RecipeTagsView(recipe: recipe)

                    Divider()

                    if let ingredients = recipe.extendedIngredients {
                        Text("Ingredients")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.vertical, 4)
                        IngredientsView(ingredients: ingredients)
                    }

                    Divider()

                    if let analyzedInstructions = recipe.analyzedInstructions?.first?.steps {
                        Text("Instructions")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.vertical, 4)
                        InstructionsView(instructions: analyzedInstructions)
                    }

                    }

                }
                .padding(.horizontal)
            }
        .navigationTitle(recipe.title)
            .padding()
        }
    }
#Preview {
    RecipeDetailView(recipe: Recipe.mock)
}

