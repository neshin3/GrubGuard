//
//  RecipeViewModel.swift
//  GrubGuard
//
//  Created by Nestor on 4/19/25.
//

import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiKey = "1acf9d6e74msh39817eed9e3ebaep138f34jsna4aace0526c5"
    
    func fetchRecipes(tags: String = "", number: Int = 10) async {
        isLoading = true
        errorMessage = nil
        
        var components = URLComponents(string: "https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/random")!
        components.queryItems = [
            URLQueryItem(name: "tags", value: tags),
            URLQueryItem(name: "number", value: "\(number)")
        ]
        
        guard let url = components.url else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.setValue("1acf9d6e74msh39817eed9e3ebaep138f34jsna4aace0526c5", forHTTPHeaderField: "x-rapidapi-key")
        request.setValue("spoonacular-recipe-food-nutrition-v1.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                errorMessage = "Server error: \(httpResponse.statusCode)"
                isLoading = false
                return
            }
            
            let decodedResponse = try JSONDecoder().decode(RecipeSearchResponse.self, from: data)
            self.recipes = decodedResponse.recipes
            
            print("Recipes fetched: \(self.recipes)")  // Print out fetched recipes
            
        } catch {
            print("Error fetching recipes:", error.localizedDescription)
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
}


