//
//  APIService.swift
//  MealDetailsApp
//
//  Created by Sumit on 14/09/24.
//

import Foundation

// Model for the Dessert List API
struct Meal: Identifiable, Codable {
    let id: String
    let name: String
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
    }
}

// Model for Meal Detail API
struct MealDetail: Codable {
    let id: String?
    let name: String?
    let instructions: String?
    let thumbnail: String?
    let ingredients: [String]
    let measurements: [String]

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case instructions = "strInstructions"
        case thumbnail = "strMealThumb"
        case ingredients
        case measurements
    }
    
    // Helper function to extract ingredients and measurements from JSON
    static func extractIngredients(from data: [String: String?]) -> (ingredients: [String], measurements: [String]) {
        var ingredients: [String] = []
        var measurements: [String] = []
        
        for i in 1...20 {
            if let ingredient = data["strIngredient\(i)"] as? String, !ingredient.isEmpty {
                ingredients.append(ingredient)
            }
            if let measurement = data["strMeasure\(i)"] as? String, !measurement.isEmpty {
                measurements.append(measurement)
            }
        }
        
        // Filter out empty values, if any slipped through
        ingredients = ingredients.filter { !$0.isEmpty }
        measurements = measurements.filter { !$0.isEmpty }
        
        return (ingredients, measurements)
    }
}

// Helper structs to decode API responses
struct MealResponse: Codable {
    let meals: [Meal]
}

struct MealDetailResponse: Codable {
    let meals: [[String: String?]]  // Dynamically map meal detail data
}
