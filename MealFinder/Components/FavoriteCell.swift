//
//  FavoriteCell.swift
//  MealFinder
//
//  Created by Mohamed Adel on 01/05/2026.
//

import SwiftUI

struct FavoriteCell: View {
    let recipe: Recipe
    let proxy: GeometryProxy
    @Environment(\.colorScheme) var colorScheme
    
    var onDeleteTapped: () -> Void
    
    var body: some View {
        VStack {

            ZStack(alignment: .topTrailing) {
                recipeImage

                Button {
                    onDeleteTapped()
                } label: {
                    Image(systemName: "trash.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .symbolRenderingMode(.multicolor)
                }
                .padding(.trailing, 10)
                .padding(.top, 10)

            }
            
            recipeName
                .padding(.vertical, 10)
                .padding(.horizontal, 8)
            
            Spacer()
          
            VStack {
                
                if let category = recipe.category {
                    Text("\(category)")
                        .font(.subheadline.bold())
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.cellChipText)
                        .background(Color.cellChipBackground)
                        .clipShape(Capsule())
                }

            }
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, alignment: .center)

        }
        .frame(height: proxy.size.height * 0.3)
        .padding(.bottom, 15)
        .background(.quaternary.opacity(colorScheme == .light ? 0.3 : 0.5))
        .clipShape(RoundedRectangle(cornerRadius: 15))

    }
}

#Preview {    
    GeometryReader { proxy in
        FavoriteCell(recipe: MockData.recipe, proxy: proxy) {
            print("Delete")
        }
    }
}

extension FavoriteCell {
    
    var recipeImage: some View {
        
        AsyncImage(url: URL(string: recipe.thumbnail ?? "")){ image in
            image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity)
                .frame(height: proxy.size.height * 0.15)
                .clipped()
        } placeholder: {
            ProgressView()
                .frame(width: 100, height: 100)
        }
    }
    
    
    var recipeName: some View {
        Text(recipe.name)
            .font(.headline)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(2)
    }
    
}

