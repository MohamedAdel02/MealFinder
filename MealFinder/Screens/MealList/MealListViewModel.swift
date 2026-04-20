//
//  MealListViewModel.swift
//  MealFinder
//
//  Created by Mohamed Adel on 20/04/2026.
//

import Foundation


@Observable
class MealListViewModel {
    
    var meals = [Meal]()
    
    init (ingredients: [Ingredient]) {
        
        Task {
            do {
                let mealsId = try await getMealsId(from: ingredients)
                let mealSet = try await getMealsDetails(of: mealsId)
                meals = setMealsScore(mealSet, for: ingredients)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func getMealsId(from ingredients: [Ingredient]) async throws -> Set<String> {
        let task = Task {
            let urls = getUrls(from: ingredients)
            let dataArr = try await fetchMeals(from: urls)
            var mealsIdSet = Set<String>()
            for data in dataArr {
                let meals = try JSONDecoder().decode(Meals.self, from: data).meals
                mealsIdSet.formUnion(meals.map{ $0.id })
            }
            
            return mealsIdSet
        }
        
        return try await task.value
    }
    
    func getMealsDetails(of mealsId: Set<String>) async throws -> Set<Meal> {
        let task = Task {
            let urls = getUrls(from: mealsId)
            let dataArr = try await fetchMeals(from: urls)
            var meals = Set<Meal>()
            for data in dataArr {
                if let meal = try JSONDecoder().decode(Meals.self, from: data).meals.first {
                    meals.insert(meal)
                }
            }
            return meals
        }
        return try await task.value
    }
    
    func setMealsScore(_ meals: Set<Meal>, for userIngredients: [Ingredient]) -> [Meal] {
        
        let userIngredientNames = Set(userIngredients.map { $0.name.lowercased() })

        var mealsArr = [Meal]()
        for var meal in meals {
            let matchedCount = meal.ingredients.filter {
                userIngredientNames.contains($0.name.lowercased())
            }.count
            meal.score = meal.ingredients.count - matchedCount
            mealsArr.append(meal)
        }
        mealsArr.sort { $0.score < $1.score }
        return mealsArr
    }
    
    func getUrls(from mealsId: Set<String>) -> [String] {
        var urls = [String]()
        for id in mealsId {
            urls.append("\(K.API.mealDetails)\(id)")
        }
        return urls
    }

    func getUrls(from ingredients: [Ingredient]) -> [String] {
        var urls = [String]()
        for ingredient in ingredients {
            urls.append("\(K.API.meals)\(ingredient.name)")
        }
        return urls
    }
    
    func fetchMeals(from urls: [String]) async throws -> [Data] {
        try await withThrowingTaskGroup(of: Data.self) { group in
            for url in urls {
                group.addTask {
                    return try await NetworkManager.shared.fetchData(url: url)
                }
            }
            
            var dataArr = [Data]()
            for try await data in group {
                dataArr.append(data)
            }
            return dataArr
        }
        
    }
    
}
