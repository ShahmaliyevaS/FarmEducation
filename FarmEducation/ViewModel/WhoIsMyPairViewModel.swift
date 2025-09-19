//
//  WhoIsMyPairViewModel.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 29.07.25.
//

import Foundation

class WhoIsMyPairViewModel: ObservableObject {
    
    @Published var currentRound: [String] = []
    @Published var selectedImages: [Int] = []
    @Published var correctImages: [Int] = []
    @Published var allAnswers: Int = 0
    @Published var correctAnswers: Int = 0
    
    private var allQuestions: [String] = []
    
    func loadQuestions() {
        allQuestions = DataLoader.whoIsMYpair
        loadNextQuestion()
    }
    
    func loadNextQuestion() {
        currentRound = allQuestions.shuffled().prefix(6).flatMap { [$0, $0] }
        selectedImages = []
        correctImages = []
        allAnswers = 0
        correctAnswers = 0
    }
    
    func selectImage(at index: Int, audio: AudioManager) {
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
