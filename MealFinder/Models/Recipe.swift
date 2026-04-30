//
//  Recipe.swift
//  MealFinder
//
//  Created by Mohamed Adel on 30/04/2026.
//

import SwiftData

@Model
class Recipe {
    
    var name: String
    var category: String?
    var thumbnail: String?
    var instructions: String?
    var ingredients: [Ingredient]
    
    struct Ingredient: Hashable, Codable {
        let name: String
        let measure: String
    }
    
    
    init(name: String, category: String? = nil, thumbnail: String? = nil, instructions: String? = nil, ingredients: [Ingredient]) {
        self.name = name
        self.category = category
        self.thumbnail = thumbnail
        self.instructions = instructions
        self.ingredients = ingredients
    }
    
    
}
