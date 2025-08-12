//
//  WhoIsMyPairViewModel.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 29.07.25.
//

import Foundation

class WhoIsMyPairViewModel: ObservableObject {
    
    var allQuestions: [String] = []
    
    @Published var currentRound: [String]?
    
    func loadQuestions() {
        allQuestions = DataLoader.whoIsMYpair

        loadNextQuestion()
    }
    
    func loadNextQuestion() {
        currentRound = allQuestions.shuffled().prefix(6).flatMap { [ $0, $0 ] }
    }
}
