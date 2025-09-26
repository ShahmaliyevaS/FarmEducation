//
//  WhichAnimalsShadowViewModelTest.swift
//  FarmEducationTests
//
//  Created by Sevinj Shahmaliyeva on 26.09.25.
//

import XCTest
@testable import FarmEducation

final class WhichAnimalsShadowViewModelTest: XCTestCase {
    var vm: WhichAnimalsShadowViewModel!
    var mockRound = QuestionRound(question: "rabbit", options: ["fox", "wolf"], correctAnswer: "rabbit")
    
    override func setUp() {
        super.setUp()
        let gameType: GameType = .whatAnimalsEat
        let audioManager = AudioManager.shared
        
        vm = WhichAnimalsShadowViewModel(gameType, audioManager)
    }
    
    override func tearDown() {
        vm = nil
        super.tearDown()
    }
    
    func testIsHiddenHandleAnswerForCorrectAnswer() {
        vm.currentRound = mockRound
        vm.handleAnswer("rabbit")
        XCTAssertTrue(vm.hidden)
    }
    
    func testIsHiddenHandleAnswerForFalseAnswer() {
        vm.currentRound = mockRound
        vm.handleAnswer("wolf")
        XCTAssertFalse(vm.hidden)
    }
    
    func testResetRoundStates() {
        vm.resetRoundStates()
        XCTAssertFalse(vm.hidden)
    }
}

