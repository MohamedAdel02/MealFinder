//
//  NetworkManager.swift
//  MealFinder
//
//  Created by Mohamed Adel on 12/04/2026.
//

import Foundation


struct NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    func fetchData(url: String) async throws -> Data {
        
        guard let url = URL(string: url) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        return data
    }
    
}

