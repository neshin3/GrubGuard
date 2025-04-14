//
//  RecipeTagView.swift
//  GrubGuard
//
//  Created by Nestor on 4/27/25.
//

import SwiftUI

struct RecipeTagsView: View {
    let recipe: Recipe

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 10) {
            if recipe.vegetarian { Label("Vegetarian", systemImage: "leaf") }
            if recipe.vegan { Label("Vegan", systemImage: "leaf.circle") }
            if recipe.glutenFree { Label("Gluten Free", systemImage: "checkmark.shield") }
            if recipe.dairyFree { Label("Dairy Free", systemImage: "drop") }
            if recipe.veryHealthy { Label("Very Healthy", systemImage: "heart") }
            if recipe.cheap { Label("Budget Friendly", systemImage: "dollarsign.circle") }
            if recipe.veryPopular { Label("Popular Choice", systemImage: "star.fill") }
            if recipe.sustainable { Label("Eco-Friendly", systemImage: "leaf.fill") }
            if recipe.lowFodmap { Label("Low FODMAP", systemImage: "leaf.arrow.circlepath") }
        }
    }
}

#Preview {
    RecipeTagsView(recipe: Recipe.mock)
}
