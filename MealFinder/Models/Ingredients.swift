//
//  Ingredients.swift
//  MealFinder
//
//  Created by Mohamed Adel on 12/04/2026.
//

import Foundation

struct Ingredients: Codable {
    
    var ingredients: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case ingredients = "meals"
    }
}


struct Ingredient: Codable, Identifiable {
    
    let id: String
    let name: String
    var isSelected: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id = "idIngredient"
        case name = "strIngredient"
    }
}
