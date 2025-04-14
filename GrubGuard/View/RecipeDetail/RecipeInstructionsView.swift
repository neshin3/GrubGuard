//
//  RecipeInstructionsView.swift
//  GrubGuard
//
//  Created by Nestor on 4/16/25.
//

import SwiftUI

struct InstructionsView: View {
    let instructions: [InstructionStep]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Instructions")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            ForEach(instructions) { step in
                VStack(alignment: .leading, spacing: 8) {
                    HStack(alignment: .top) {
                        Text("\(step.number).")
                            .font(.headline)
                            .foregroundColor(.blue)

                        Text(step.step)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                    }
                    
                    if let ingredients = step.ingredients, !ingredients.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(ingredients, id: \.id) { ingredient in
                                    VStack {
                                        if let imageUrl = ingredient.image {
                                            AsyncImage(url: URL(string: "https://spoonacular.com/cdn/ingredients_100x100/\(imageUrl)")) { image in
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 50, height: 50)
                                                    .cornerRadius(8)
                                            } placeholder: {
                                                Color.gray.opacity(0.3)
                                                    .frame(width: 50, height: 50)
                                                    .cornerRadius(8)
                                            }
                                        }

                                        Text(ingredient.localizedName)
                                            .font(.caption)
                                            .frame(width: 60)
                                            .multilineTextAlignment(.center)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    InstructionsView(instructions: [
        InstructionStep(
            number: 1,
            step: "Separate Oreos, leaving 12 pcs without cream intact and round.",
            ingredients: [
                InstructionIngredient(
                    id: 10018166,
                    name: "oreo cookies",
                    localizedName: "Oreo Cookies",
                    image: "oreos.png"
                ),
                InstructionIngredient(
                    id: 1053,
                    name: "cream",
                    localizedName: "cream",
                    image: "fluid-cream.jpg"
                )
            ],
            equipment: nil
        ),
        InstructionStep(
            number: 2,
            step: "Put the rest of the biscuits together with the filling into a food processor and pulse fine.",
            ingredients: [
                InstructionIngredient(
                    id: 18009,
                    name: "biscuits",
                    localizedName: "biscuits",
                    image: "buttermilk-biscuits.jpg"
                )
            ],
            equipment: [
                InstructionEquipment(
                    id: 404771,
                    name: "food processor",
                    localizedName: "food processor",
                    image: "food-processor.png"
                )
            ]
        )
    ])
}
