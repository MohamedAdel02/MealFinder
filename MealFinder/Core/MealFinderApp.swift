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
    @State var router = Router()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(router)
        }
        .modelContainer(for: Recipe.self)
    }
}
