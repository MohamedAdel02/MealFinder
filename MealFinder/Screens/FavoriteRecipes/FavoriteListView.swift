//
//  FavoriteListView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 01/05/2026.
//

import SwiftUI
import SwiftData

enum FavoriteNavDestination: Hashable {
    case RecipeDetailsView(recipe: Recipe)
}

struct FavoriteListView: View {
    
    @Query var recipes: [Recipe]
    @Environment(Router.self) var favoriteRouter
    @Environment(\.modelContext) private var context
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        if recipes.isEmpty {
            ContentUnavailableView(
                "No Favorites Yet",
                systemImage: "heart.slash",
                description: Text("Meals you save will appear here.")
            )
        } else {
            
            GeometryReader { proxy in
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(recipes) { recipe in
                            FavoriteCell(recipe: recipe, proxy: proxy) {
                                context.delete(recipe)
                            }
                            .onTapGesture {
                                favoriteRouter.path.append(FavoriteNavDestination.RecipeDetailsView(recipe: recipe))
                            }
                            
                        }
                    }
                    .padding(.horizontal, 15)
                }
                .navigationDestination(for: FavoriteNavDestination.self) { destination in
                    switch destination {
                    case .RecipeDetailsView(let recipe):
                        RecipeDetailsView(recipe: recipe, proxy: proxy) {
                            context.delete(recipe)
                        } onAddTapped: {
                            context.insert(recipe)
                        }
                    }
                }
                
            }
            .navigationTitle("Favorite Recipes")
        } 
        
    }


}

#Preview {
    FavoriteListView()
        .environment(Router())
}
