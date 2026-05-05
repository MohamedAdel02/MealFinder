//
//  LoadingView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 02/05/2026.
//

import SwiftUI
struct LoadingView: View {
    @State private var animate = false
    
    var body: some View {
        
        HStack(spacing: 12) {
            ForEach(0..<3) { index in
                RoundedRectangle(cornerRadius: 4)
                    .fill(.accent)
                    .frame(width: 12, height: 40)
                    .scaleEffect(y: animate ? 1.0 : 0.3, anchor: .bottom)
                    .animation(
                        .easeInOut(duration: 0.5)
                        .repeatForever()
                        .delay(Double(index) * 0.15),
                        value: animate
                    )
            }
        }
        .padding(40)
        .background(.accent.opacity(0.15), in: RoundedRectangle(cornerRadius: 30))
        .onAppear { animate = true }
    }
}
            
#Preview {
    LoadingView()
}
