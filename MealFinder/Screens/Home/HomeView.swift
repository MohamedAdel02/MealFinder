//
//  HomeView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 11/04/2026.
//

import SwiftUI

enum HomeNavDestination: Hashable {
    case searchView(searchText: String)
    case mealListView(ingredients: [Ingredient])
}

struct HomeView: View {
    
    @State var homeViewModel = HomeViewModel()
    @State var path = NavigationPath()
    @State var searchText = ""
    @Environment(Router.self) var homeRouter
    @FocusState private var isFocused: Bool
    
    var body: some View {

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
            .navigationDestination(for: HomeNavDestination.self, destination: { distination in
                switch distination {
                case .searchView(let searchText):
                    SearchView(homeViewModel: homeViewModel, searchText: searchText)
                case .mealListView(let ingredients):
                    MealListView(ingredients: ingredients, proxy: proxy)
                }
            })

        }
    }

}

#Preview {
    HomeView()
        .environment(Router())
}

extension HomeView {
    
    var ingredientTextField: some View {
        HStack {
            
            Button {
                isFocused = false
                
                let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
                if !text.isEmpty {
                    homeRouter.path.append(HomeNavDestination.searchView(searchText: searchText))
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
                    homeRouter.path.append(HomeNavDestination.searchView(searchText: searchText))
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
            isFocused = false
            homeRouter.path.append(HomeNavDestination.mealListView(ingredients: homeViewModel.ingredients.filter({$0.isSelected})))
        } label: {
            Text("Find recipes →")
                .font(Font.system(size: 26).bold())
                .foregroundStyle(.white)
                .frame(width: 230, height: 80)
                .background(homeViewModel.ingCount == 0 ? .gray : .accent)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .disabled(homeViewModel.ingCount == 0)
        
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
