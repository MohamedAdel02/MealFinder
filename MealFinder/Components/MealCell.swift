//
//  MealCell.swift
//  MealFinder
//
//  Created by Mohamed Adel on 20/04/2026.
//

import SwiftUI

struct MealCell: View {
    
    let meal: Meal
    let proxy: GeometryProxy
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: meal.thumbnail ?? "")){ image in
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
            
            Text(meal.name)
                .font(.headline)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(2)
                .padding(.vertical, 10)
                .padding(.horizontal, 8)
            
            Spacer()
          
            
            VStack(alignment: .leading) {
                if let category = meal.category {
                    Text("\(category)")
                        .font(.subheadline)
                        .bold()
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color(red: 0.6, green: 0.31, blue: 0.04))
                        .background((Color(red: 0.52, green: 0.31, blue: 0.04)).opacity(colorScheme == .light ? 0.1 : 0.2))
                        .clipShape(Capsule())
                }
                
                
                if meal.score == 0 {
                    Text("Full match")
                        .bold()
                        .font(.subheadline)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.accent)
                        .background(Color.accentColor.opacity(colorScheme == .light ? 0.1 : 0.3))
                        .clipShape(Capsule())
                } else {
                    Text("+\(meal.score) items")
                        .bold()
                        .font(.subheadline)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color(red: 0.6, green: 0.31, blue: 0.04))
                        .background((Color(red: 0.52, green: 0.31, blue: 0.04)).opacity(colorScheme == .light ? 0.1 : 0.2))
                        .clipShape(Capsule())
                }
            }
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, alignment: .leading)
            

        }
        .frame(height: proxy.size.height * 0.35)
        .padding(.bottom, 15)
        .background(.quaternary.opacity(colorScheme == .light ? 0.3 : 0.5))
        .clipShape(RoundedRectangle(cornerRadius: 15))

    }
}

#Preview {
    GeometryReader { proxy in
        MealCell(meal: MockData.meal, proxy: proxy)
    }
}
