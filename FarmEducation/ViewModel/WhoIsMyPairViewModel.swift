//
//  WhoIsMyPairViewModel.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 29.07.25.
//

import Foundation
import SwiftUI

class WhoIsMyPairViewModel: ObservableObject {
    
    @Published var currentRound: [String] = []
    @Published var selectedImages: [Int] = []
    @Published var correctImages: [Int] = []
    @Published var allAnswers: Int = 0
    @Published var correctAnswers: Int = 0
    @Published var newGame = false
    
    private var audio: AudioManager
    private var gameType: GameType
    
    private var allQuestions: [String] = []
    
    init(_ gameType: GameType, _ audioManager: AudioManager) {
        self.gameType = gameType
        self.audio = audioManager
        loadQuestions()
    }
    
    func loadQuestions() {
        allQuestions = DataLoader.whoIsMYpair
        loadNextQuestion()
    }
    
    func loadNextQuestion() {
        currentRound = allQuestions.shuffled().prefix(6).flatMap { [$0, $0] }.shuffled()
        selectedImages = []
        correctImages = []
        allAnswers = 0
        correctAnswers = 0
    }
    
    func playNewGame() {
        ScoreManager.shared.saveScore(
            gameType,
            askedQuestionsCount: allAnswers,
            correctAnswersCount: correctAnswers
        )
        loadNextQuestion()
        newGame.toggle()
        audio.play(name: Constants.UI.cards)
        playNotificationHaptic(type: .error)
    }
    
    func isSelected(_ index: Int) -> Bool {
        return selectedImages.contains(index)
    }
    
    func getDegress(_ condition: Bool) -> Double {
        return condition ? 180 : 0
    }
    
    func selectImage(at index: Int) {
        guard !selectedImages.contains(index) && selectedImages.count < 2 else { return }
        
        selectedImages.append(index)
        
        if selectedImages.count == 2 {
            allAnswers += 1
            if currentRound[selectedImages[0]] == currentRound[selectedImages[1]] {
                audio.play(name: Constants.UI.correct)
                playNotificationHaptic(type: .success)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.correctImages += self.selectedImages
                    self.correctAnswers += 1
                    self.selectedImages.removeAll()
                }
            } else {
                audio.play(name: Constants.UI.error)
                playNotificationHaptic(type: .error)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.selectedImages.removeAll()
                }
            }
        }
    }
}
