//
//  HomeView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 11/04/2026.
//

import SwiftUI

struct HomeView: View {
    
    @State var ingredientText = ""
    @State var homeViewModel = HomeViewModel()
    
    var body: some View {
        
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Text("What's in your kitchen?")
                        .font(.system(size: 30).bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 30)
                        .padding(.horizontal, 20)
                    
                    ingredientTextField
                        .padding(.horizontal, 20)
                        .padding(.top, 15)
                    
                    if homeViewModel.ingredients.count != 0 {
                        ingredientCounter
                            .padding(.top, 15)
                            .padding(.leading, 25)
                    }

                    
                    ingredientList
                        .padding(.top, 10)
                        .padding(.horizontal, 20)

                    
                    Spacer()
                    
                    findRecipesButton
                        .padding(.bottom, 20)
                    
                }
                .onAppear {
                    homeViewModel.screenWidth = proxy.size.width
                }
            }

        }

    }
}

#Preview {
    HomeView()
}

extension HomeView {
    
    var ingredientTextField: some View {
        HStack {
            
            Button {
                print("")
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 25).bold())
                    .foregroundStyle(Color.secondary)
            }

            TextField(text: $ingredientText) {
                Text("Add an ingredient ...")
                    .font(Font.system(size: 25).bold())
                    .foregroundStyle(Color.secondary)
            }
            .font(Font.system(size: 22).bold())
            .autocorrectionDisabled(true)
            .padding(.vertical, 20)
            .padding(.horizontal, 10)
            
        }
        .padding(.horizontal, 20)
        .background(Color.init(uiColor: .systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    
    var ingredientCounter: some View {
        Text("Your ingredients (\(homeViewModel.ingredients.count))")
            .foregroundStyle(Color.secondary)
            .font(.system(size: 19).bold())
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    var findRecipesButton: some View {
        Button {
            homeViewModel.ingredients.append(ingredientText)
        } label: {
            Text("Find recipes →")
                .font(Font.system(size: 26).bold())
                .foregroundStyle(.white)
                .frame(width: 230, height: 80)
                .background(Color.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
    
    
    var ingredientList: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            
            ForEach(homeViewModel.groupedIngredients, id: \.self) { ingredients in
                HStack(spacing: 12) {
                    ForEach(ingredients, id: \.self) { ingredient in
                        ChipView(chipText: ingredient)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
  
    }
    
}
