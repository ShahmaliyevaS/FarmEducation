//
//  QuestionViewModel.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 22.05.25.
//

import Foundation

class QuestionViewModel: ObservableObject {
    @Published var currentRound: QuestionRound?
    @Published var firstFalseAnswer: String = ""
    @Published var answer: String = ""
    @Published var disabledAnswers: Set<String> = []
    @Published var offsetAnimation = false
    @Published var questionImageAnimation = false
    @Published var correctAnswersCount = 0
    
    private var allQuestions: [Question] = []
    private var allQuestionsId: [Int] = []
    private var unAskedQuestions: [Int] = []
    private var askedQuestions: [Int] = []
    private var askedQuestionCount = 0
    
    private var gameType: GameType
    private var audio: AudioManager
    
    init(_ gameType: GameType, _ audioManager: AudioManager) {
        self.gameType = gameType
        self.audio = audioManager
        loadQuestions()
    }
    
    func loadQuestions() {
        switch gameType {
        case .whatAnimalsEat:
            allQuestions = DataLoader.whatAnimalsEatQuestions
        case .whereAnimalsLive:
            allQuestions = DataLoader.whereAnimalsLiveQuestions
        case .whichAnimalsShadow:
            allQuestions = DataLoader.whichAnimalsShadowQuestions
        case .whosePartIsThis:
            allQuestions = DataLoader.whosePartIsThisQuestions
        case .whoIsMyPair:
            allQuestions = []
        }
        
        allQuestionsId = Array(0..<allQuestions.count)
        unAskedQuestions = allQuestionsId.shuffled()
        askedQuestions = []
        loadNextQuestion()
    }
    
    func loadNextQuestion() {
        resetRoundStates()
        guard !unAskedQuestions.isEmpty else {
            unAskedQuestions = allQuestionsId.shuffled()
            askedQuestions = []
            return
        }
        
        let id = unAskedQuestions.removeLast()
        var options = allQuestions[id].falseAnswer
        options.append(allQuestions[id].trueAnswer)
        options.shuffle()
        
        currentRound = QuestionRound(
            question: allQuestions[id].question,
            options: options,
            correctAnswer: allQuestions[id].trueAnswer
        )
        
        askedQuestionCount += 1
        askedQuestions.append(id)
        
    }
    
    func resetRoundStates() {
        firstFalseAnswer = ""
        answer = ""
        disabledAnswers = []
        offsetAnimation = false
        questionImageAnimation.toggle()
    }
    
    func handleAnswer(_ option: String) {
        guard let round = currentRound, !disabledAnswers.contains(option) else { return }
        answer = option
        
        if isCorrect(option) {
            correctAnswersCount += 1
        }
        audio.play(name: isCorrect(option) ? Constants.UI.correct : Constants.UI.error)
        playNotificationHaptic(type: isCorrect(option) ? .success :.error)
        
        
        if firstFalseAnswer.isEmpty && !isCorrect(option) {
            firstFalseAnswer = option
            disabledAnswers.insert(option)
            return
        }
        
        offsetAnimation.toggle()
        disabledAnswers.formUnion(round.options)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.loadNextQuestion()
        }
    }
    
    func getAskedQuestionCount() -> Int {
        return askedQuestionCount - 1
    }
    
    func isCorrect(_ option: String) -> Bool {
        return option == currentRound?.correctAnswer
    }
    
    func isSelected(_ option: String) -> Bool {
        return option == answer
    }
    
    func isFirstFalseAnswer(_ option: String) -> Bool{
        return option == firstFalseAnswer
    }
    
    func getOffset(_ option: String, width: Double, height: Double) -> CGSize {
        guard let round = currentRound else {return CGSize(width: 0, height: 0) }
        let index = round.options.firstIndex(of: option)
        let centerOffset = index == 0 ? width : (index == 1 ? 0 : -width)
        
        if isSelected(option) {
            if isCorrect(option) || disabledAnswers.count > 1 {
                return CGSize(width: centerOffset, height: -height)
            }
        }
        return CGSize(width: 0, height: 0)
    }
    
    func exitGame(dismiss: @escaping () -> Void, gameType: GameType) {
        ScoreManager.shared.saveScore(
            gameType,
            askedQuestionsCount: getAskedQuestionCount(),
            correctAnswersCount: correctAnswersCount
        )
        dismiss()
    }
}
