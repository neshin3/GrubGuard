//
//  IngredientsView.swift
//  GrubGuard
//
//  Created by Nestor on 4/16/25.
//

import SwiftUI

struct IngredientsView: View {
    let ingredients: [Ingredient]
    @StateObject private var viewModel = IngredientsViewModel()

    @State private var groceries: [Ingredient] = [] // Mutable grocery list state
    @State private var checkedItems: Set<Int> = [] // Start with an empty set of checked items

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(ingredients) { ingredient in
                        HStack {
                            Button(action: {
                                viewModel.toggleIngredient(ingredient) // Toggle checked state in ViewModel
                            }) {
                                Image(systemName: viewModel.checkedIngredients.contains(ingredient.id) ? "checkmark.square.fill" : "square")
                                    .foregroundColor(.blue)
                                    .imageScale(.large)
                            }
                            Text(ingredient.original)
                        }
                    }
                }
            }

            Button(action: {
                viewModel.addToGroceryList(ingredients: ingredients)
                groceries = viewModel.groceries // Update the groceries list with selected items
            }) {
                Text("➕ Add to Grocery List")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding(.top)
            }

            NavigationLink(destination: GroceryListView(groceries: $groceries, checkedItems: $checkedItems)) {
                Text("Go to Grocery List")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.top)
            }
        }
        .padding()
    }
}

#Preview {
    IngredientsView(ingredients: [
        Ingredient(
            id: 19125,
            aisle: "Nut butters, Jams, and Honey",
            image: "hazelnut-chocolate-spread.jpg",
            consistency: "SOLID",
            name: "Nutella",
            nameClean: "chocolate hazelnut spread",
            original: "75g Nutella",
            originalName: "Nutella",
            amount: 75,
            unit: "g"
        ),
        Ingredient(
            id: 12345,
            aisle: "Cheese",
            image: "cream-cheese.jpg",
            consistency: "SOLID",
            name: "Cream Cheese",
            nameClean: "cream cheese",
            original: "1 package cream cheese",
            originalName: "Cream Cheese",
            amount: 1,
            unit: "package"
        )
    ])
}
