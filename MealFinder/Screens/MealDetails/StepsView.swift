//
//  StepsView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 27/04/2026.
//

import SwiftUI

struct StepsView: View {
    
    @State var steps = [String]()
    let instructions: String
    let mealDetailsViewModel = MealDetailsViewModel()
    
    init(instructions: String?) {
        self.instructions = instructions ?? ""
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text("Steps")
                .bold()
                .foregroundStyle(Color.init(uiColor: .darkGray))
                .padding(.vertical, 10)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(steps.indices, id: \.self) { index in
                HStack(alignment: .top) {
                    Text("\(index + 1)")
                        .bold()
                        .foregroundStyle(.background)
                        .frame(width: 25, height: 25)
                        .background(Color.accent)
                        .clipShape(Circle())
                        .padding(.trailing, 5)
                    
                    Text(steps[index])

                }
                .padding(.bottom, 10)
            }
            .padding(.horizontal, 25)
        }
        .task {
            if instructions != "" {
                steps = await mealDetailsViewModel.getSteps(of: instructions)
            }
        }
    }
        
}

#Preview {
    StepsView(instructions: MockData.meal.instructions)
}
