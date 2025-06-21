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
        case .whoEatsThisFood:
            allQuestions = FarmData.whoEatsThisFoodQuestions
        case .colorMatching:
            allQuestions = FarmData.colorMatchingQuestions
        }
        
        allQuestionsId = Array(0..<allQuestions.count)
        unAskedQuestions = allQuestionsId
        unAskedQuestions.shuffle()
        loadNextQuestion()
    }
    
    func loadNextQuestion() {
        if unAskedQuestions.isEmpty {
            unAskedQuestions = allQuestionsId
            unAskedQuestions.shuffle()
            askedQuestions = []
        } else {
            let id = unAskedQuestions.last!
            
            unAskedQuestions.remove(at: unAskedQuestions.count - 1)
            
            if !askedQuestions.contains(id) {
                askedQuestionCount += 1
                var allOptions = allQuestions[id].falseAnswer
                allOptions.append(allQuestions[id].trueAnswer)
                currentRound = QuestionRound(
                    question: allQuestions[id].question,
                    options: Array(allOptions.shuffled()),
                    correctAnswer: allQuestions[id].trueAnswer
                )
                askedQuestions.append(allQuestions[id].id)
            } else {
                loadNextQuestion()
            }
        }
    }
    
    func getAskedQuestionCount() -> Int {
        return askedQuestionCount
    }
}
