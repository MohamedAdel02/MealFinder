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
    
    var ingredients : [String] = [] {
        didSet {
            groupedIngredients = updateGroupedArr(with: ingredients)
        }
    }
    
    var groupedIngredients : [[String]] = []
    var screenWidth = 0.0
    
    func updateGroupedArr(with ingredients: [String]) -> [[String]] {
        
        var groupedArr: [[String]] = []
        var tempArr: [String] = []
        var totalWidth = 0.0
        let paddingWidth = 75.0
        
        for ingredient in ingredients {
            let strWidth = ingredient.widthOfString(usingFont: .systemFont(ofSize: K.ChipViewFontSize, weight: .bold))
            let strWidthWithPadding = strWidth + paddingWidth
            
            if (strWidthWithPadding + totalWidth < screenWidth) {
                totalWidth += strWidthWithPadding
                tempArr.append(ingredient)
            } else {
                totalWidth = strWidthWithPadding
                groupedArr.append(tempArr)
                tempArr.removeAll()
                tempArr.append(ingredient)
            }
        }
        
        groupedArr.append(tempArr)
        return groupedArr
    }
    
}
