//
//  MealListView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 20/04/2026.
//

import SwiftUI

struct MealListView: View {
    
    @State var mealListViewModel: MealListViewModel
    let proxy: GeometryProxy
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(ingredients: [Ingredient], proxy: GeometryProxy) {
        mealListViewModel = MealListViewModel(ingredients: ingredients)
        self.proxy = proxy
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(mealListViewModel.meals) { meal in
                    MealCell(meal: meal, proxy: proxy)
                }
            }
            .padding(.horizontal, 15)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Meals")
        .navigationBarTitleDisplayMode(.large)
    }
         
}

#Preview {
    GeometryReader { proxy in
        MealListView(ingredients: Array(MockData.ingredients[6...8]), proxy: proxy)
    }
}
