//
//  HomeViewModel.swift
//  MealFinder
//
//  Created by Mohamed Adel on 11/04/2026.
//

import Foundation
import Observation
import UIKit

@Observable
class HomeViewModel {
    
    var ingredients: [Ingredient] = [] {
        didSet {
            let selectedIngredients = ingredients.filter({$0.isSelected})
            groupedIngredients = updateGroupedIng(with: selectedIngredients)
        }
    }
    
    var groupedIngredients: [[String]] = []
    var screenWidth = 0.0
    
    init () {
        fetchIngredients()
    }
    
    func fetchIngredients() {
        Task {
            do {
                let data = try await NetworkManager.shared.fetchData(url: K.API.ingredients)
                ingredients = try JSONDecoder().decode(Ingredients.self, from: data).ingredients
                //print(allIngredients)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateGroupedIng(with ingredients: [Ingredient]) -> [[String]] {
        
        var groupedArr: [[String]] = []
        var tempArr: [String] = []
        var totalWidth = 0.0
        let paddingWidth = 75.0
        
        for ingredient in ingredients {
            let ingredientName = ingredient.name
            let strWidth = ingredientName.widthOfString(usingFont: .systemFont(ofSize: K.ChipViewFontSize, weight: .bold))
            let strWidthWithPadding = strWidth + paddingWidth
            
            if (strWidthWithPadding + totalWidth < screenWidth) {
                totalWidth += strWidthWithPadding
                tempArr.append(ingredient.id)
            } else {
                totalWidth = strWidthWithPadding
                groupedArr.append(tempArr)
                tempArr.removeAll()
                tempArr.append(ingredient.id)
            }
        }
        
        groupedArr.append(tempArr)
        return groupedArr
    }
    
}
