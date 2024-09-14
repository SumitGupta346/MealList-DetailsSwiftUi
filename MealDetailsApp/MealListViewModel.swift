//
//  MealListViewModel.swift
//  MealDetailsApp
//
//  Created by Sumit on 14/09/24.
//

import Foundation

@MainActor
class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var selectedMealDetail: MealDetail? = nil
    @Published var isLoading: Bool = false
    
    let baseURL = "https://themealdb.com/api/json/v1/1"

    // Fetch meals in the "Dessert" category
    func fetchDessertMeals() async {
        isLoading = true
        guard let url = URL(string: "\(baseURL)/filter.php?c=Dessert") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let mealResponse = try JSONDecoder().decode(MealResponse.self, from: data)
            let sortedMeals = mealResponse.meals.sorted(by: { $0.name < $1.name })
            meals = sortedMeals
        } catch {
            print("Failed to fetch dessert meals: \(error.localizedDescription)")
        }
        isLoading = false
    }
    
    // Fetch meal details by ID
    func fetchMealDetail(by id: String) async {
        isLoading = true
        guard let url = URL(string: "\(baseURL)/lookup.php?i=\(id)") else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let mealDetailResponse = try JSONDecoder().decode(MealDetailResponse.self, from: data)
            if let mealData = mealDetailResponse.meals.first {
                let (ingredients, measurements) = MealDetail.extractIngredients(from: mealData)
                selectedMealDetail = MealDetail(
                    id: mealData["idMeal"] as? String,
                    name: mealData["strMeal"] as? String,
                    instructions: mealData["strInstructions"] as? String,
                    thumbnail: mealData["strMealThumb"] as? String,
                    ingredients: ingredients,
                    measurements: measurements
                )
            }
        } catch {
            print("Failed to fetch meal detail: \(error.localizedDescription)")
        }
        isLoading = false
    }
}
