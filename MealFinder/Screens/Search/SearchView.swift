//
//  SearchView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 16/04/2026.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var ingredients: [Ingredient]
    @Environment(\.dismiss) var dismiss
    var searchText: String
    
    var body: some View {
        
        List($ingredients) { $ingredient in
            if ingredient.name.lowercased().contains(searchText.lowercased()) {
                HStack {
                    Text(ingredient.name)
                        .font(.title3)
                    Spacer()
                    Image(systemName: ingredient.isSelected ? "checkmark.app.fill" : "app")
                        .foregroundColor(ingredient.isSelected ? .accent : .primary)
                        .font(.title)
                }
                .contentShape(Rectangle())
                .padding(.horizontal, 20)
                .onTapGesture {
                    ingredient.isSelected.toggle()
                }
            }
        }
        .navigationTitle("Select Your Ingredients")
        .navigationBarBackButtonHidden(true)
        .scrollIndicators(.hidden)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    SearchView(ingredients: .constant(MockData.ingredients), searchText: "Ch")
}
