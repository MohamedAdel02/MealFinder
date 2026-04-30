//
//  MealDetailsView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 24/04/2026.
//

import SwiftUI
import SwiftData

struct MealDetailsView: View {
    
    var mealDetailsViewModel = MealDetailsViewModel()
    let meal: Meal
    let userIngredients: [String]
    let proxy: GeometryProxy
    let customRed = Color(red: 0.85, green: 0.2, blue: 0.15)
    @Environment(\.modelContext) private var context

    
    init(meal: Meal, ingredients: [Ingredient], proxy: GeometryProxy) {
        self.userIngredients = ingredients.map{ $0.name }
        self.meal = mealDetailsViewModel.updateIngredientsOrder(meal: meal, userIngredients: userIngredients)
        self.proxy = proxy
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            
            mealImage
            
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

//            StepsView(meal: meal, MealDetailsViewModel: mealDetailsViewModel)
//                .padding(.top, 20)
            
            Button {
                let recipe = Recipe(
                    name: meal.name,
                    category: meal.category,
                    thumbnail: meal.thumbnail,
                    instructions: meal.instructions,
                    ingredients: meal.ingredients.map { Recipe.Ingredient(name: $0.name, measure: $0.measure)})
                context.insert(recipe)
            } label: {
                Text("Add to Favorites")
                    .font(.title3.bold())
                    .frame(width: 230, height: 60)
                    .background(.accent)
                    .foregroundStyle(.background)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.top, 30)

            
        }
        
    }
}

#Preview {
    GeometryReader { proxy in
        MealDetailsView(meal: MockData.meal, ingredients: Array(MockData.ingredients[4...9]), proxy: proxy)
    }
}

extension MealDetailsView {
    
    var mealImage: some View {
        AsyncImage(url: URL(string: meal.thumbnail ?? "")){ image in
            image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: proxy.size.height * 0.3)
                .clipped()
        } placeholder: {
            ProgressView()
                .frame(width: 100, height: proxy.size.height * 0.3)
        }
    }
    
    
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
    
    
    
}
