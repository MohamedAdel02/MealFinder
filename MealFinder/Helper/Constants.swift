//
//  Constants.swift
//  MealFinder
//
//  Created by Mohamed Adel on 11/04/2026.
//

import Foundation


struct K {
    
    static let ChipViewFontSize: CGFloat = 20
    static private let baseURL = "https://www.themealdb.com/api/json/v1/1"
    
    struct API {
        static let ingredients = "\(K.baseURL)/list.php?i=list"
        static let meals = "\(K.baseURL)/filter.php?i="
        static let mealDetails = "\(K.baseURL)/lookup.php?i="
    }
    
}
