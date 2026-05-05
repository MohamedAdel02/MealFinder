//
//  MealDetailsViewModel.swift
//  MealFinder
//
//  Created by Mohamed Adel on 24/04/2026.
//

import Foundation

@Observable
class MealDetailsViewModel {
    
    func updateIngredientsOrder(meal: Meal, userIngredients: [String]) -> Meal {
        var meal = meal
        var mealIngs = meal.ingredients
        for index in 0..<mealIngs.count {
            if userIngredients.contains(mealIngs[index].name) {
                let item = mealIngs.remove(at: index)
                mealIngs.insert(item, at: 0)

            }
        }
        meal.ingredients = mealIngs
        return meal
    }
    
    func getSteps(of instructions: String) async -> [String] {
        
        do {
            let setps = try await GeminiManager.shared.getSteps(instructions)
            return setps
        } catch {
            print(error.localizedDescription)
            return []
        }
                
    }
    
}
