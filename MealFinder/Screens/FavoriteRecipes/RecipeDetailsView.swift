//
//  RecipeDetailsView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 01/05/2026.
//

import SwiftUI

struct RecipeDetailsView: View {
    let recipe: Recipe
    @State var isFav = true
    @State var showToast: toastType = .none
    @State var toastTask: Task<Void, Never>?
    let proxy: GeometryProxy
    
    var onDeleteTapped: () -> Void
    var onAddTapped: () -> Void

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
            
            if isFav {
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
        RecipeDetailsView(recipe: MockData.recipe, proxy: proxy){
            print("Delete")
        } onAddTapped: {
            print("ADd")
        }
    }
}


extension RecipeDetailsView {
    
    var recipeImage: some View {
        
        AsyncImage(url: URL(string: recipe.thumbnail ?? "")) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: proxy.size.height * 0.3)
                    .clipped()

            case .failure:
                Image(systemName: "photo.badge.exclamationmark")
                    .font(.system(size: 36))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .frame(height: proxy.size.height * 0.3)
                    .background(Color(.systemGray6))

            case .empty:
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: proxy.size.height * 0.3)

            @unknown default:
                EmptyView()
            }
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

    var removeFromFavoriteButton: some View {
        Button {
            onDeleteTapped()
            isFav.toggle()
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
            onAddTapped()
            isFav.toggle()
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
