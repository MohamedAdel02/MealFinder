//
//  SearchView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 16/04/2026.
//

import SwiftUI

struct SearchView: View {
    
    var homeViewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    var searchText: String
    
    var body: some View {
        
        List(homeViewModel.ingredients.indices, id: \.self) { index in
            let ingredient = homeViewModel.ingredients[index]
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
                    homeViewModel.ingredients[index].isSelected.toggle()
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
    SearchView(homeViewModel: HomeViewModel(), searchText: "Ch")
}
