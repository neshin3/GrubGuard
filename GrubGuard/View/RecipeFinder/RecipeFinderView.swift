//
//  RecipeFinderView.swift
//  GrubGuard
//
//  Created by Nestor on 4/26/25.
//

import SwiftUI

struct RecipeFinderView: View {
    let recipes: [Recipe]

    var body: some View {
        ScrollView {
            VStack {
                ForEach(recipes) { recipe in
                    NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                        VStack(alignment: .leading, spacing: 10) {
                            AsyncImage(url: URL(string: recipe.image)) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 180)
                                    .cornerRadius(10)
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                                    .frame(height: 180) 
                            }
                            
                            Text(recipe.title)
                                .font(.headline)
                                .padding(.horizontal)
                                .padding(.bottom, 5)
                            
                            HStack {
                                Text("Ready in \(recipe.readyInMinutes) mins")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                Spacer()
                                
                                Text("Serves \(recipe.servings)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding(.horizontal)
                        }
                        .background(Color(.systemGray6))
                        .cornerRadius(12)
                        .padding(.horizontal)
                    }
                }
            }
        }
        .navigationTitle("Recipe Finder")
    }
}
