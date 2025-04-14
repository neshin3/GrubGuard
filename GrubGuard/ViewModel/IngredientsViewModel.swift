//
//  IngredientsViewModel.swift
//  GrubGuard
//
//  Created by Nestor on 4/16/25.
//

import SwiftUI

class IngredientsViewModel: ObservableObject {
    @Published var checkedIngredients: Set<Int> = []  // Tracks checked items by their id
    @Published var groceries: [Ingredient] = []  // List of all groceries

    // Toggle ingredient checked state
    func toggleIngredient(_ ingredient: Ingredient) {
        if checkedIngredients.contains(ingredient.id) {
            checkedIngredients.remove(ingredient.id)
        } else {
            checkedIngredients.insert(ingredient.id)
        }
    }

    // Add checked items to grocery list
    func addToGroceryList(ingredients: [Ingredient]) {
        groceries.append(contentsOf: ingredients.filter { checkedIngredients.contains($0.id) })
    }

    // Delete an ingredient (example logic)
    func deleteIngredient(_ ingredient: Ingredient) {
        // Remove ingredient from both groceries and checked items
        groceries.removeAll { $0.id == ingredient.id }
        checkedIngredients.remove(ingredient.id)
    }
}
