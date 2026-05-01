//
//  RecipeDetailsView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 01/05/2026.
//

import SwiftUI

struct RecipeDetailsView: View {
    let recipe: Recipe
    let proxy: GeometryProxy
    
    var onDeleteTapped: () -> Void

    var body: some View {
        ScrollView(showsIndicators: false) {
            
            recipeImage
            
            Text("\(recipe.name)")
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

            StepsView(instructions: recipe.instructions)
                .padding(.top, 20)
            
            Button {
                onDeleteTapped()
            } label: {
                Text("Remove from Favorites")
                    .font(.title3.bold())
                    .frame(width: 230, height: 60)
                    .background(.red)
                    .foregroundStyle(.background)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
            }
            .padding(.vertical, 30)
            
        }
    }
}

#Preview {
    GeometryReader { proxy in
        RecipeDetailsView(recipe: MockData.recipe, proxy: proxy) {
            print("Delete")
        }
    }
}


extension RecipeDetailsView {
    
    var recipeImage: some View {
        AsyncImage(url: URL(string: recipe.thumbnail ?? "")){ image in
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
        
        ForEach(recipe.ingredients, id: \.self) { ingredient in
            HStack {
                
                Image(systemName: "circle.fill")
                    .font(.caption2)
                    .padding(.trailing, 5)
                    .foregroundStyle(.accent)
                
                Text(ingredient.name)
                    .font(.headline.bold())
                
                Spacer()
                
                Text(ingredient.measure)
                    .font(.callout.bold())
                    .frame(width: 140, alignment: .leading)


            }
            .padding(.bottom, 5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)

    }

}
