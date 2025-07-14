//
//  QuestionViewModel.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 22.05.25.
//

import Foundation

class QuestionViewModel: ObservableObject {
    
    var allQuestions: [Question] = []
    var allQuestionsId: [Int] = []
    var unAskedQuestions: [Int] = []
    var askedQuestions: [Int] = []
    var askedQuestionCount = 0
    
    @Published var currentRound: QuestionRound?
    
    func loadQuestions(for gameType: GameType) {
        switch gameType {
        case .whatAnimalsEat:
            allQuestions = FarmData.whatAnimalsEatQuestions
        case .whereAnimalsLive:
            allQuestions = FarmData.whereAnimalsLiveQuestions
        case .whichAnimalsShadow:
            allQuestions = FarmData.whichAnimalsShadow
        }
        
        allQuestionsId = Array(0..<allQuestions.count)
        unAskedQuestions = allQuestionsId
        unAskedQuestions.shuffle()
        loadNextQuestion()
    }
    
    func loadNextQuestion() {
        if unAskedQuestions.isEmpty{
            unAskedQuestions = allQuestionsId
            unAskedQuestions.shuffle()
            askedQuestions = []
        }
        
        let id = unAskedQuestions.last!
        var allOptions = allQuestions[id].falseAnswer
        
        unAskedQuestions.remove(at: unAskedQuestions.count - 1)
        askedQuestionCount += 1
        allOptions.append(allQuestions[id].trueAnswer)
        currentRound = QuestionRound(
            question: allQuestions[id].question,
            options: Array(allOptions.shuffled()),
            correctAnswer: allQuestions[id].trueAnswer
        )
        askedQuestions.append(id)
    }
    
    func getAskedQuestionCount() -> Int {
        return askedQuestionCount
    }
}
