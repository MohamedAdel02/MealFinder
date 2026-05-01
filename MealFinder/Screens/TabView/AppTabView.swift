//
//  AppTabView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 30/04/2026.
//

import SwiftUI

struct AppTabView: View {
    
    @State var homeRouter = Router()
    @State var favoriteRouter = Router()
    
    var body: some View {
        
        TabView {
            Tab("Home", systemImage: "house") {
                NavigationStack(path: $homeRouter.path) {
                    HomeView()
                }
                .environment(homeRouter)
            }
            
            Tab("Favorites" , systemImage: "heart") {
                NavigationStack(path: $favoriteRouter.path) {
                    FavoriteListView()
                }
                .environment(favoriteRouter)
            }
            
        }
        
    }
}

#Preview {
    AppTabView()
        .environment(Router())
}
