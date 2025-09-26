//
//  QuestionViewModelTest.swift
//  FarmEducationTests
//
//  Created by Sevinj Shahmaliyeva on 19.09.25.
//

import XCTest
@testable import FarmEducation

final class QuestionViewModelTest: XCTestCase {
    var vm: QuestionViewModel!
    var mockRound = QuestionRound(question: "carrot", options: ["fox", "wolf"], correctAnswer: "rabbit")
    
    override func setUp() {
        super.setUp()
        let gameType: GameType = .whatAnimalsEat
        let audioManager = AudioManager.shared
        
        vm = QuestionViewModel(gameType, audioManager)
    }
    
    override func tearDown() {
        vm = nil
        super.tearDown()
    }
    
    func testLoadQuestionsForGameType() {
        XCTAssertFalse(vm.allQuestions.isEmpty, "Questions should not be empty")
        XCTAssertEqual(vm.allQuestions.count, vm.allQuestionsId.count, "allQuestions and allQuestionsId count mismatch")
        XCTAssertEqual(vm.allQuestions.count-1, vm.unAskedQuestions.count, "unAskedQuestions count mismatch after load")
        XCTAssertNotNil(vm.currentRound, "currentRound should be initialized")
        XCTAssertEqual(vm.askedQuestions.count, 1, "One question should be marked as asked")
        XCTAssertNotNil(vm.currentRound, "currentRound should not be nil")
    }
    
    func testLoadNextQuestionUpdatesState() {
        let initialUnAskedCount = vm.unAskedQuestions.count
        vm.loadNextQuestion()
        
        XCTAssertEqual(vm.askedQuestions.count, 2, "Two questions should be marked as asked (one from loadQuestions, one from loadNextQuestion)")
        XCTAssertEqual(vm.unAskedQuestions.count, initialUnAskedCount - 1, "One question should be removed from unAskedQuestions")
        XCTAssertEqual(vm.askedQuestionCount, 2, "askedQuestionCount should increment")
        XCTAssertNotNil(vm.currentRound, "currentRound should not be nil after loading next question")
    }
    
    func testAskedQuestionCount() {
        _ = vm.getAskedQuestionCount()
        
        XCTAssertEqual(vm.askedQuestionCount, 1, "Initially one question should be asked after loadQuestions")
    }
    
    func testResetFunction() {
        let animation = vm.questionImageAnimation
        vm.resetRoundStates()
        
        XCTAssertEqual(vm.firstFalseAnswer, "", "firstFalseAnswer should reset to empty string")
        XCTAssertEqual(vm.answer, "", "answer should reset to empty string")
        XCTAssertEqual(vm.disabledAnswers.count, 0, "disabledAnswers should reset to empty array")
        XCTAssertFalse(vm.offsetAnimation, "offsetAnimation should reset to false")
        XCTAssertNotEqual(animation, vm.questionImageAnimation, "questionImageAnimation should change after reset")
    }
    
    func testHandleCorrectAnswer() {
        vm.currentRound = mockRound
        vm.disabledAnswers = []
        let correctAnswerCount = vm.correctAnswersCount
        vm.handleAnswer("rabbit")
        
        XCTAssertEqual(vm.answer, "rabbit")
        XCTAssertEqual(vm.correctAnswersCount, correctAnswerCount+1, "correctAnswersCount should increase for correct answer")
        XCTAssertTrue(vm.offsetAnimation, "offsetAnimation should toggle after correct answer")
        XCTAssertEqual(vm.disabledAnswers.count, 2, "all options should be disabled after correct answer")
    }
    
    func testHandleSecondWrongAnswer() {
        vm.currentRound = mockRound
        vm.firstFalseAnswer = "wolf"
        let correctAnswerCount = vm.correctAnswersCount
        vm.handleAnswer("fox")
        
        XCTAssertEqual(vm.answer, "fox")
        XCTAssertEqual(vm.correctAnswersCount, correctAnswerCount, "correctAnswersCount should not increase for wrong answer")
        XCTAssertFalse(vm.firstFalseAnswer.isEmpty, "firstFalseAnswer should already be set before second wrong answer")
    }
    
    func testHandleFirstWrongAnswer() {
        vm.currentRound = mockRound
        vm.disabledAnswers = []
        vm.firstFalseAnswer = ""
        let correctAnswerCount = vm.correctAnswersCount
        vm.handleAnswer("fox")
        
        XCTAssertEqual(vm.answer, "fox", "answer should be set to the selected option")
        XCTAssertEqual(vm.firstFalseAnswer, "fox", "firstFalseAnswer should be set to the first wrong option")
        XCTAssertEqual(vm.correctAnswersCount, correctAnswerCount, "correctAnswersCount should not increase for wrong answer")
    }
}
