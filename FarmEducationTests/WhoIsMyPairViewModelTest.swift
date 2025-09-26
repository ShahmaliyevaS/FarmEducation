//
//  WhoIsMyPairViewModelTest.swift
//  FarmEducationTests
//
//  Created by Sevinj Shahmaliyeva on 19.09.25.
//

import XCTest
@testable import FarmEducation

final class WhoIsMyPairViewModelTest: XCTestCase {
    var vm: WhoIsMyPairViewModel!
    let mockCurrentRound = ["fox", "bear", "wolf", "elephant", "wolf", "bear", "elephant", "fox"]
    
    override func setUp() {
        super.setUp()
        let gameType: GameType = .whatAnimalsEat
        let audioManager = AudioManager.shared
        
        vm = WhoIsMyPairViewModel(gameType, audioManager)
    }
    
    func testLoadQuestionsInitializesCurrentRound() {
        XCTAssertFalse(vm.allQuestions.isEmpty, "allQuestions should be populated after loadQuestions")
        XCTAssertNotNil(vm.currentRound, "currentRound should be initialized after loadQuestions")
        XCTAssertEqual(vm.currentRound.count, 12, "currentRound should contain 12 elements (6 pairs)")
        for element in Set(vm.currentRound) {
            let count = vm.currentRound.filter { $0 == element }.count
            XCTAssertEqual(count, 2, "Each element in currentRound should appear exactly twice")
        }
        
        for element in vm.currentRound {
            XCTAssertTrue(vm.allQuestions.contains(element), "All elements in currentRound should come from allQuestions")
        }
    }
    
    func testLoadNextQuestion() {
        vm.loadNextQuestion()
        XCTAssertTrue(vm.selectedImages.isEmpty, "selectedImages should be empty after loading next question")
        XCTAssertTrue(vm.correctImages.isEmpty, "correctImages should be empty after loading next question")
        XCTAssertEqual(vm.allAnswers, 0, "allAnswers should reset to 0 after loading next question")
        XCTAssertEqual(vm.correctAnswers, 0, "correctAnswers should reset to 0 after loading next question")
    }
    
    func testPlayGame() {
        let newGame = vm.newGame
        vm.playNewGame()
        XCTAssertNotEqual(newGame, vm.newGame, "newGame should change after starting a new game")
    }
    
    func testRightOptionSelectImage() {
        let expectation = self.expectation(description: "Wait for asyncAfter block")
        let allAnswers = vm.allAnswers
        let correctImages = vm.correctImages
        let correctAnswers = vm.correctAnswers
        vm.currentRound = mockCurrentRound
        vm.selectedImages = [1]
        vm.selectImage(at: 5)
        
        XCTAssertEqual(vm.selectedImages.count, 2, "selectedImages should contain 2 images immediately after right selection")
        XCTAssertEqual(vm.allAnswers, allAnswers + 1, "allAnswers should increment by 1 after right selection")

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            XCTAssertEqual(self.vm.correctImages.count, correctImages.count + 2, "correctImages should increase by 2 after right selection")
            XCTAssertEqual(self.vm.correctAnswers, correctAnswers + 1, "correctAnswers should increment by 1 after right selection")
            XCTAssertTrue(self.vm.selectedImages.isEmpty, "selectedImages should be cleared after right selection")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0)
    }
    
    func testFAlsetOptionSelectImage() {
        let expectation = self.expectation(description: "Wait for asyncAfter block")
        let allAnswers = vm.allAnswers
        let correctImages = vm.correctImages
        let correctAnswers = vm.correctAnswers
        vm.currentRound = mockCurrentRound
        vm.selectedImages = [1]
        vm.selectImage(at: 2)
        
        XCTAssertEqual(vm.selectedImages.count, 2, "selectedImages should contain 2 images immediately after false selection")
        XCTAssertEqual(vm.allAnswers, allAnswers+1, "allAnswers should increment by 1 after selection")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.vm.correctImages.count, correctImages.count , "correctImages should remain the same after false selection")
            XCTAssertEqual(self.vm.correctAnswers, correctAnswers, "correctAnswers should remain the same after false selection")
            XCTAssertTrue(self.vm.selectedImages.isEmpty, "selectedImages should be cleared after false selection")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2.0)
    }
}
