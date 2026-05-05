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

            ImageView(url: meal.thumbnail, height: proxy.size.height * 0.15)
            
            mealName
                .padding(.vertical, 10)
                .padding(.horizontal, 8)
            
            Spacer()
          
            VStack {
                
                if let category = meal.category {
                    Text("\(category)")
                        .font(.subheadline.bold())
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(Color.cellChipText)
                        .background(Color.cellChipBackground)
                        .clipShape(Capsule())
                }
                
                if meal.score == 0 {
                    fullMatchText
                } else {
                    numOfItems
                }
            }
            .padding(.horizontal, 15)
            .frame(maxWidth: .infinity, alignment: .center)

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

extension MealCell {

    var mealName: some View {
        Text(meal.name)
            .font(.headline)
            .bold()
            .frame(maxWidth: .infinity, alignment: .leading)
            .lineLimit(2)
    }
    
    
    var fullMatchText: some View {
        Text("Perfect match")
            .bold()
            .font(.subheadline)
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.accent)
            .background(Color.accentColor.opacity(colorScheme == .light ? 0.1 : 0.3))
            .clipShape(Capsule())
    }
    
    var numOfItems: some View {
        Text("+\(meal.score) items")
            .bold()
            .font(.subheadline)
            .padding(.horizontal, 15)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity)
            .foregroundStyle(Color.cellChipText)
            .background(Color.cellChipBackground)
            .clipShape(Capsule())
    }
    
}
