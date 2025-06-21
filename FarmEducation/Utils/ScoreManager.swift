//
//  GameManager.swift.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 20.06.25.
//

import Foundation

class ScoreManager {
    static let score = ScoreManager()
    
    func save(_ score: Score, for key: String) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(score) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }

    func get(for key: GameType) -> Score? {
        if let data = UserDefaults.standard.data(forKey: key.rawValue) {
            let decoder = JSONDecoder()
            return try? decoder.decode(Score.self, from: data)
        }
        return nil
    }
}
