//
//  MealDetailsView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 24/04/2026.
//

import SwiftUI
import SwiftData

enum toastType {
    case addToFav
    case removeFromFav
    case none
}

struct MealDetailsView: View {
    
    var mealDetailsViewModel = MealDetailsViewModel()
    let meal: Meal
    @State var showToast: toastType = .none
    @State var toastTask: Task<Void, Never>?
    let userIngredients: [String]
    let proxy: GeometryProxy
    let recipe: Recipe
    let customRed = Color(red: 0.85, green: 0.2, blue: 0.15)
    @Query var recipes: [Recipe]
    @Environment(\.modelContext) private var context

    
    init(meal: Meal, ingredients: [Ingredient], proxy: GeometryProxy) {
        self.userIngredients = ingredients.map{ $0.name }
        self.meal = mealDetailsViewModel.updateIngredientsOrder(meal: meal, userIngredients: userIngredients)
        self.proxy = proxy
        
        recipe = Recipe(
            name: meal.name,
            category: meal.category,
            thumbnail: meal.thumbnail,
            instructions: meal.instructions,
            ingredients: meal.ingredients.map { Recipe.Ingredient(name: $0.name, measure: $0.measure)})
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            ImageView(url: meal.thumbnail, height: proxy.size.height * 0.3)
            
            Text("\(meal.name)")
                .font(.title.bold())
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Ingredients")
                .bold()
                .foregroundStyle(Color.init(uiColor: .darkGray))
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            IngredientsList
                .padding(.leading, 20)
                .padding(.trailing, 10)

            StepsView(instructions: meal.instructions)
                .padding(.top, 20)
            
            if recipes.contains(recipe) {
                removeFromFavoriteButton
            } else {
                addToFavoriteButton
            }
        }
        .overlay(alignment: .top) {
            if showToast == .removeFromFav {
                Text("Removed from Favorites ✓")
                    .font(.subheadline.bold())
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(.red.opacity(0.9), in: Capsule())
            } else if showToast == .addToFav {
                Text("Add to Favorites ✓")
                    .font(.subheadline.bold())
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(.accent.opacity(0.9), in: Capsule())
            }
        }
        
    }
}

#Preview {
    GeometryReader { proxy in
        MealDetailsView(meal: MockData.meal, ingredients: Array(MockData.ingredients[4...9]), proxy: proxy)
    }
}

extension MealDetailsView {
    
    var IngredientsList: some View {
        
        ForEach(meal.ingredients, id: \.self) { ingredient in
            HStack {
                
                Image(systemName: "circle.fill")
                    .foregroundStyle(userIngredients.contains(ingredient.name) ? Color.accentColor : customRed)
                    .font(.caption2)
                    .padding(.trailing, 5)
                
                Text(ingredient.name)
                    .font(.headline.bold())
                    .foregroundStyle(userIngredients.contains(ingredient.name) ? Color.primary : customRed)
                
                Spacer()
                
                Text(ingredient.measure)
                    .font(.callout.bold())
                    .frame(width: 140, alignment: .leading)
                    .foregroundStyle(userIngredients.contains(ingredient.name) ? Color.primary : customRed)
            }
            .padding(.bottom, 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var removeFromFavoriteButton: some View {
        Button {
            context.delete(recipe)
            toastTask?.cancel()
            showToast = .removeFromFav
            toastTask = Task {
                try? await Task.sleep(for: .seconds(1.5))
                guard !Task.isCancelled else { return }
                showToast = .none
            }
        } label: {
            Text("Removie from Favorites")
                .font(.title3.bold())
                .frame(width: 250, height: 60)
                .background(.red)
                .foregroundStyle(.background)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(.vertical, 30)
    }
    
    var addToFavoriteButton: some View {
        Button {
            context.insert(recipe)
            toastTask?.cancel()
            showToast = .addToFav
            toastTask = Task {
                try? await Task.sleep(for: .seconds(1.5))
                guard !Task.isCancelled else { return }
                showToast = .none
            }
        } label: {
            Text("Add to Favorites")
                .font(.title3.bold())
                .frame(width: 230, height: 60)
                .background(.accent)
                .foregroundStyle(.background)
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(.vertical, 30)
    }
}
