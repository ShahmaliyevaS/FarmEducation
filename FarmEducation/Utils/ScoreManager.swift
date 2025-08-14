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
    
    func saveScore(_ gameType:GameType, askedQuestionsCount: Int, correctAnswersCount: Int) {
        var bestScore = 0
        var bestScoreQuestionCount = 0
        if let score = ScoreManager.score.get(for: gameType) {
            bestScore = score.best
            bestScoreQuestionCount = score.bestCount
        }else {
            bestScore = correctAnswersCount
            bestScoreQuestionCount = askedQuestionsCount
        }
        
        if bestScore == correctAnswersCount {
            bestScoreQuestionCount = bestScoreQuestionCount < askedQuestionsCount ? bestScoreQuestionCount : askedQuestionsCount
        } else {
            bestScoreQuestionCount = bestScore>=correctAnswersCount ? bestScoreQuestionCount : askedQuestionsCount
            bestScore = bestScore>=correctAnswersCount ? bestScore : correctAnswersCount
        }
        
        let newScore = Score(recent: correctAnswersCount, recentCount: askedQuestionsCount, best: bestScore, bestCount: bestScoreQuestionCount)
        ScoreManager.score.save(newScore, for: gameType.rawValue)
    }
}
