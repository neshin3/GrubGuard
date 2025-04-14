//
//  GroceryListView.swift
//  GrubGuard
//
//  Created by Nestor on 4/24/25.
//

import SwiftUI

struct GroceryListView: View {
    @Binding var groceries: [Ingredient] // Use @Binding for groceries array
    @Binding var checkedItems: Set<Int> // Use @Binding for checkedItems

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Grocery List")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            if groceries.isEmpty {
                Text("No items added yet.")
                    .foregroundColor(.secondary)
                    .italic()
            } else {
                ForEach(groceries, id: \.id) { ingredient in
                    HStack(spacing: 12) {
                        Button(action: {
                            toggleChecked(ingredient)
                        }) {
                            Image(systemName: checkedItems.contains(ingredient.id) ? "checkmark.square.fill" : "square")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }

                        if let imageUrl = ingredient.image {
                            AsyncImage(url: URL(string: "https://spoonacular.com/cdn/ingredients_100x100/\(imageUrl)")) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                            } placeholder: {
                                Color.gray.opacity(0.3)
                                    .frame(width: 50, height: 50)
                                    .cornerRadius(8)
                            }
                        }

                        VStack(alignment: .leading) {
                            Text(ingredient.originalName ?? ingredient.name)
                                .font(.headline)
                                .strikethrough(checkedItems.contains(ingredient.id), color: .gray)
                                .foregroundColor(checkedItems.contains(ingredient.id) ? .gray : .primary)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }

            Button(action: {
                deleteCheckedItems() // Delete all checked items
            }) {
                Text("Delete All Toggled Items")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.top)
            }
        }
        .padding()
    }

    private func toggleChecked(_ ingredient: Ingredient) {
        if checkedItems.contains(ingredient.id) {
            checkedItems.remove(ingredient.id)
        } else {
            checkedItems.insert(ingredient.id)
        }
    }

    private func deleteCheckedItems() {
        groceries.removeAll { ingredient in
            checkedItems.contains(ingredient.id)
        }
        checkedItems.removeAll() // Remove checked items
    }
}

#Preview {
    GroceryListView(groceries: .constant([
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
    ]), checkedItems: .constant([])) // Start with an empty set
}
