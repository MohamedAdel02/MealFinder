//
//  HomeView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 11/04/2026.
//

import SwiftUI

struct HomeView: View {
    
    @State var homeViewModel = HomeViewModel()
    @State var searchText = ""
    @State private var navigate = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        NavigationStack {
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
                    
                    if !homeViewModel.groupedIngredients.allSatisfy({$0.isEmpty}) {
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
                    searchText = ""
                    homeViewModel.screenWidth = proxy.size.width
                }
                .navigationDestination(isPresented: $navigate) {
                    SearchView(ingredients: $homeViewModel.ingredients, searchText: searchText.trimmingCharacters(in: .whitespacesAndNewlines))
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
                isFocused = false
                if !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    navigate = true
                }
            } label: {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 25).bold())
                    .foregroundStyle(Color.secondary)
            }


            TextField(text: $searchText) {
                Text("Add an ingredient ...")
                    .font(Font.system(size: 25).bold())
                    .foregroundStyle(Color.secondary)
            }
            .font(Font.system(size: 22).bold())
            .focused($isFocused)
            .autocorrectionDisabled(true)
            .padding(.vertical, 20)
            .padding(.horizontal, 10)
            .submitLabel(.search)
            .onSubmit {
                if searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    isFocused = false
                } else {
                    navigate = true
                }
            }
            
        }
        .padding(.horizontal, 20)
        .background(Color.init(uiColor: .systemGray5))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
    
    
    var ingredientCounter: some View {
        Text("Your ingredients (\(homeViewModel.groupedIngredients.flatMap{$0}.count))")
            .foregroundStyle(Color.secondary)
            .font(.system(size: 19).bold())
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    
    var findRecipesButton: some View {
        Button {
            //print(homeViewModel.ingredients)
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
            
            ForEach($homeViewModel.groupedIngredients, id: \.self) { $ingredientsId in
                HStack(spacing: 12) {
                    ForEach($ingredientsId, id: \.self) { $ingredientId in
                        if let index = homeViewModel.ingredients.firstIndex( where: {$0.id == ingredientId}) {
                            ChipView(ingredient: $homeViewModel.ingredients[index])
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
  
    }
    
}
