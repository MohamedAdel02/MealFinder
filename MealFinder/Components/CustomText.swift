//
//  CustomText.swift
//  MealFinder
//
//  Created by Mohamed Adel on 22/04/2026.
//

import SwiftUI

struct CustomText: View {

    let text: String
    @Environment(\.colorScheme) var colorScheme
    
    init(_ text: String) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .font(.headline.bold())
            .frame(maxWidth: .infinity)
            .foregroundStyle(.accent)
            .padding(15)
            .background(Color.accentColor.opacity(colorScheme == .light ? 0.1 : 0.3))
            .frame(maxWidth: .infinity)
            .clipShape(RoundedRectangle(cornerRadius: 15))
        
        
    }
}

#Preview {
    CustomText("If the rule you followed brought you to this of what use was the rule?")
}
