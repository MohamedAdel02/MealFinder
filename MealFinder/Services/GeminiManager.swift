//
//  GeminiManager.swift
//  MealFinder
//
//  Created by Mohamed Adel on 26/04/2026.
//

import Foundation

struct GeminiManager {
    
    static let shared = GeminiManager()
    
    private init() { }
    
    
    func getSteps(_ rawInstructions: String) async throws -> [String] {

        // MARK: - API Configuration
        // API keys are stored in `Keys.swift` which is excluded from version control via .gitignore
        // To run this project, create a `Keys.swift` file with the following structure:
        //
        // struct Keys {
        //     static let geminiAPIKey = "YOUR_GEMINI_API_KEY"
        // }
        //
        // Get your free API key from: https://aistudio.google.com/app/apikey
        
        let url =  "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash-lite:generateContent?key=\(Keys.geminiAPIKey)"

        let prompt = """
        Parse the following cooking instructions into a clean array of individual steps.
        Return ONLY a valid JSON array of strings, no extra text, no markdown.
        Example: ["Step one.", "Step two.", "Step three."]

        Instructions:
        \(rawInstructions)
        """

        let body: [String: Any] = [
            "contents": [
                ["parts": [["text": prompt]]]
            ]
        ]

        let data = try await NetworkManager.shared.post(url: url, body: body)
        
        return try await decodeResponse(data: data)
        
    }
    
    
    
    private func decodeResponse(data: Data) async throws -> [String] {
                
        let geminiResponse = try JSONDecoder().decode(GeminiResponse.self, from: data)
        guard let resposne = geminiResponse.candidates.first?.content.parts.first?.text else {
            throw URLError(.badServerResponse)
        }

        // remove the opening ```json and closing ```
        let cleanedText = resposne
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        let instructions = try JSONDecoder().decode([String].self, from: Data(cleanedText.utf8))

        return instructions
        
    }
    
}
