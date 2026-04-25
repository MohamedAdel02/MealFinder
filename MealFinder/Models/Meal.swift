//
//  Meal.swift
//  MealFinder
//
//  Created by Mohamed Adel on 20/04/2026.
//

import Foundation

struct Meals: Codable {
    var meals: [Meal]
}

struct Meal: Codable, Hashable, Identifiable {
    let id: String
    let name: String
    var score: Int = 0
    let category: String?
    let thumbnail: String?
    let instructions: String?
    var ingredients: [Ingredient]
    
    struct Ingredient: Hashable {
        let name: String
        let measure: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case category = "strCategory"
        case thumbnail = "strMealThumb"
        case instructions = "strInstructions"
    }
    
    init(id: String, name: String, score: Int = 0, category: String, thumbnail: String, instructions: String, ingredients: [Ingredient]) {
        self.id = id
        self.name = name
        self.score = score
        self.category = category
        self.thumbnail = thumbnail
        self.instructions = instructions
        self.ingredients = ingredients
    }
    
    
    init(from decoder: Decoder) throws {
        // container 1 — uses your fixed enum keys
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        thumbnail = try container.decodeIfPresent(String.self, forKey: .thumbnail)
        instructions = try container.decodeIfPresent(String.self, forKey: .instructions)
        
        // container 2 — uses dynamic string keys
        let dynamicContainer = try decoder.container(keyedBy: DynamicKey.self)
        var result: [Ingredient] = []
        
        for i in 1...20 {
            let ingredientKey = DynamicKey(string: "strIngredient\(i)")
            let measureKey = DynamicKey(string: "strMeasure\(i)")
            
            let ingredient = try dynamicContainer.decodeIfPresent(String.self, forKey: ingredientKey) ?? ""
            let measure = try dynamicContainer.decodeIfPresent(String.self, forKey: measureKey) ?? ""
            
            if !ingredient.trimmingCharacters(in: .whitespaces).isEmpty {
                result.append(Ingredient(name: ingredient, measure: measure))
            }
        }
        
        self.ingredients = result
    }
}

// helper to decode any string key
struct DynamicKey: CodingKey {
    var stringValue: String
    var intValue: Int? { nil }
    
    // our custom init, takes any string and stores it
    init(string: String) { self.stringValue = string }
    
    // required by the protocol
    init?(stringValue: String) { self.stringValue = stringValue }
    init?(intValue: Int) { nil }
}
