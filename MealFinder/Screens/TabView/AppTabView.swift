//
//  AppTabView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 30/04/2026.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        
        TabView {
            Tab("Home" , systemImage: "house") {
                HomeView()
            }
            
            Tab("Favorites" , systemImage: "heart") {
                
            }
            
        }
        
    }
}

#Preview {
    AppTabView()
        .environment(Router())
}
