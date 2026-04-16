//
//  ChipView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 11/04/2026.
//

import SwiftUI

struct ChipView: View {
    
    @Binding var ingredient: Ingredient
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        HStack(spacing: 12) {
            Text(ingredient.name)
                .foregroundStyle(Color.accent)
                .font(.system(size: K.ChipViewFontSize).bold())
                .padding(.vertical, 15)

            Button {
                ingredient.isSelected = false
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 14).bold())
                    .foregroundStyle(Color.accentColor)
            }
                
        }
        .padding(.horizontal, 15)
        .background(Color.accentColor.opacity(colorScheme == .light ? 0.1 : 0.3))
        .clipShape(Capsule())
        .overlay {
            Capsule()
                .stroke(Color.accentColor)
        }
    }
  
}

#Preview {
    ChipView(ingredient: .constant(MockData.ingredients.first!))
}
