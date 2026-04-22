//
//  MealListView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 20/04/2026.
//

import SwiftUI

struct MealListView: View {
    
    @State var mealListViewModel: MealListViewModel
    @State var selectedCategory = "All"
    @Environment(\.colorScheme) var colorScheme
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

            header
                .padding(.horizontal, 20)
            
            categoriesScrollView

            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(mealListViewModel.meals.filter {
                    selectedCategory == "All" || $0.category == selectedCategory
                }) { meal in
                    MealCell(meal: meal, proxy: proxy)
                }
            }
            .padding(.horizontal, 15)
        }
        .scrollIndicators(.hidden)
        .navigationTitle("Meals")
        .navigationBarTitleDisplayMode(.large)
    }
    
    
    func isSelected(_ category: String) -> Bool {
        category == selectedCategory
    }
         
}

#Preview {
    GeometryReader { proxy in
        MealListView(ingredients: Array(MockData.ingredients[6...8]), proxy: proxy)
    }
}


extension MealListView {
    
    var header: some View {
        VStack(spacing: 10) {
            
            
            CustomText("\(mealListViewModel.meals.count) recipes found")

            if selectedCategory == "All" {
                if mealListViewModel.numOfPerfectMatch != 0 {
                    CustomText("\(mealListViewModel.numOfPerfectMatch) perfect match")
                } else {
                    Text("No perfect matches")
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.secondary)
                        .padding(15)
                        .background(Color.secondary.opacity(colorScheme == .light ? 0.1  : 0.3))
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                    
                }
            } else {
                CustomText("\(mealListViewModel.meals.filter { $0.category == selectedCategory }.count) \(selectedCategory)")
            }
        }

    }
    
    
    var categoriesScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(mealListViewModel.categories, id: \.self) { category in
                    Text(category)
                        .font(.headline.bold())
                        .padding(.horizontal, 17)
                        .padding(.vertical, 8)
                        .foregroundStyle(isSelected(category) ? .accent : .secondary)
                        .background(isSelected(category) ? Color.accentColor.opacity(colorScheme == .light ? 0.1 : 0.3) : .clear)
                        .clipShape(Capsule())
                        .overlay {
                                Capsule()
                                .stroke(isSelected(category) ? .accent : .secondary, lineWidth: 1)
                            }
                        .onTapGesture {
                            selectedCategory = category
                        }
                }
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 5)
        }
    }
    
    
}

