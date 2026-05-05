//
//  StepsView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 27/04/2026.
//

import SwiftUI

enum StepViewStatus {
    case loading
    case success
    case error
}

struct StepsView: View {
    
    @State var steps = [String]()
    @State var status: StepViewStatus = .loading
    let instructions: String
    let mealDetailsViewModel = MealDetailsViewModel()
    
    init(instructions: String?) {
        self.instructions = instructions ?? ""
    }

    var body: some View {
    
        Text("Steps")
            .bold()
            .foregroundStyle(Color.init(uiColor: .darkGray))
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
        
        if status == .loading {
            LoadingView()
                .task {
                    if instructions != "" {
                        steps = await mealDetailsViewModel.getSteps(of: instructions)
                    }
                    if steps.isEmpty {
                        status = .error
                    } else {
                        status = .success
                    }
                }
        } else if status == .success {
            stepsList
        } else if status == .error {
            ContentUnavailableView(
                "Something Went Wrong",
                systemImage: "exclamationmark.triangle",
                description: Text("Couldn't load the steps. Please try again.")
            )
        }
    }
    
        
}

#Preview {
    StepsView(instructions: MockData.meal.instructions)
}

extension StepsView {
    
    var stepsList: some View {
        VStack(alignment: .leading) {
            
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
    }
    
}
