//
//  Recipe.swift
//  GrubGuard
//
//  Created by Nestor on 4/20/25.
//

import Foundation

struct Recipe: Identifiable, Codable {
    let id: Int
    let title: String
    let image: String
    let readyInMinutes: Int
    let servings: Int
    let sourceUrl: String
    let vegetarian: Bool
    let vegan: Bool
    let glutenFree: Bool
    let dairyFree: Bool
    let veryHealthy: Bool
    let cheap: Bool
    let veryPopular: Bool
    let sustainable: Bool
    let lowFodmap: Bool
    let weightWatcherSmartPoints: Int?
    let healthScore: Int?
    let creditsText: String?
    let sourceName: String?
    let pricePerServing: Double?
    let summary: String?
    let cuisines: [String]?
    let dishTypes: [String]?
    let diets: [String]?
    let occasions: [String]?
    let instructions: String?
    let extendedIngredients: [Ingredient]?
    let analyzedInstructions: [AnalyzedInstruction]?
}

struct Ingredient: Identifiable, Codable {
    let id: Int
    let aisle: String?
    let image: String?
    let consistency: String?
    let name: String
    let nameClean: String?
    let original: String
    let originalName: String?
    let amount: Double?
    let unit: String?
}

struct AnalyzedInstruction: Codable {
    let name: String?
    let steps: [InstructionStep]?
}

struct InstructionStep: Codable, Identifiable {
    var id: Int { number }
    let number: Int
    let step: String
    let ingredients: [InstructionIngredient]?
    let equipment: [InstructionEquipment]?
}

struct InstructionIngredient: Codable {
    let id: Int
    let name: String
    let localizedName: String
    let image: String?
}

struct InstructionEquipment: Codable {
    let id: Int
    let name: String
    let localizedName: String
    let image: String?
}

struct RecipeSearchResponse: Codable {
    let recipes: [Recipe]
}


extension Recipe {
    static var mock: Recipe {
        Recipe(
            id: 636901,
            title: "Cannellini Bean Side Dish With Fennel, Red Onion, and Saffron",
            image: "https://img.spoonacular.com/recipes/636901-556x370.jpg",
            readyInMinutes: 45,
            servings: 6,
            sourceUrl: "https://spoonacular.com/cannellini-bean-side-dish-with-fennel-red-onion-and-saffron-636901",
            vegetarian: true,
            vegan: true,
            glutenFree: true,
            dairyFree: true,
            veryHealthy: false,
            cheap: false,
            veryPopular: false,
            sustainable: false,
            lowFodmap: false,
            weightWatcherSmartPoints: 3,
            healthScore: 1,
            creditsText: "Foodista.com",
            sourceName: "Foodista",
            pricePerServing: 107.8,
            summary: "If you want to add more gluten free, dairy free, lacto ovo vegetarian, and vegan recipes to your repertoire...",
            cuisines: ["American"],
            dishTypes: ["side dish"],
            diets: ["gluten free", "dairy free", "vegan"],
            occasions: nil,
            instructions: nil,
            extendedIngredients: nil,
            analyzedInstructions: nil
        )
    }
}

