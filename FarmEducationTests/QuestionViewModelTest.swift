//
//  QuestionViewModelTest.swift
//  FarmEducationTests
//
//  Created by Sevinj Shahmaliyeva on 19.09.25.
//

import XCTest
@testable import FarmEducation

final class QuestionViewModelTest: XCTestCase {
    var viewModel: QuestionViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = QuestionViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testLoadQuestionsForGameType() {
        let gameType: GameType = .whatAnimalsEat
        
        viewModel.loadQuestions(for: gameType)
        
        XCTAssertFalse(viewModel.allQuestions.isEmpty, "Questions should not be empty")
        XCTAssertEqual(viewModel.allQuestions.count, viewModel.allQuestionsId.count, "allQuestions and allQuestionsId count mismatch")
        XCTAssertEqual(viewModel.allQuestions.count-1, viewModel.unAskedQuestions.count, "unAskedQuestions count mismatch after load")
        XCTAssertNotNil(viewModel.currentRound, "currentRound should be initialized")
        XCTAssertEqual(viewModel.askedQuestions.count, 1, "One question should be marked as asked")
        XCTAssertNotNil(viewModel.currentRound, "currentRound should not be nil")
    }
    
    func testLoadNextQuestionUpdatesState() {
        viewModel.loadQuestions(for: .whereAnimalsLive)
        let initialUnAskedCount = viewModel.unAskedQuestions.count
        
        viewModel.loadNextQuestion()
        
        XCTAssertEqual(viewModel.askedQuestions.count, 2, "Two questions should be marked as asked (one from loadQuestions, one from loadNextQuestion)")
        XCTAssertEqual(viewModel.unAskedQuestions.count, initialUnAskedCount - 1, "One question should be removed from unAskedQuestions")
        XCTAssertEqual(viewModel.askedQuestionCount, 2, "askedQuestionCount should increment")
        XCTAssertNotNil(viewModel.currentRound, "currentRound should not be nil after loading next question")
    }
    
    func testAskedQuestionCount() {
            viewModel.loadQuestions(for: .whichAnimalsShadow)
            
            _ = viewModel.getAskedQuestionCount()
            
            XCTAssertEqual(viewModel.askedQuestionCount, 1, "Initially one question should be asked after loadQuestions")
        }
}
