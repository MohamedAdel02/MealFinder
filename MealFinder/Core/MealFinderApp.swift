//
//  MealFinderApp.swift
//  MealFinder
//
//  Created by Mohamed Adel on 11/04/2026.
//

import SwiftUI
import SwiftData

@main
struct MealFinderApp: App {
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
        }
        .modelContainer(for: Recipe.self)
    }
}
