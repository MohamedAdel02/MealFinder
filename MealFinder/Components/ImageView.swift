//
//  ImageView.swift
//  MealFinder
//
//  Created by Mohamed Adel on 03/05/2026.
//

import SwiftUI

struct ImageView: View {
    
    let url: String
    let height: CGFloat
    
    init(url: String?, height: CGFloat) {
        self.url = url ?? ""
        self.height = height
    }
    
    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity)
                    .frame(height: height)
                    .clipped()
                
            case .failure:
                Image(systemName: "photo.badge.exclamationmark")
                    .font(.system(size: 36))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .frame(height: height)
                    .background(Color(.systemGray6))
                
            case .empty:
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: height)
                
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    ImageView(url: MockData.recipe.thumbnail, height: 100)
}
