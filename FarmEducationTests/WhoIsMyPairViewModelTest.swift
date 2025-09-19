//
//  WhoIsMyPairViewModelTest.swift
//  FarmEducationTests
//
//  Created by Sevinj Shahmaliyeva on 19.09.25.
//

import XCTest
@testable import FarmEducation

final class WhoIsMyPairViewModelTest: XCTestCase {

    func testLoadQuestionsInitializesCurrentRound() {
        let viewModel = WhoIsMyPairViewModel()
        
        viewModel.loadQuestions()
        
        XCTAssertFalse(viewModel.allQuestions.isEmpty, "allQuestions should be populated after loadQuestions")
        XCTAssertNotNil(viewModel.currentRound, "currentRound should be initialized after loadQuestions")
        XCTAssertEqual(viewModel.currentRound?.count, 12, "currentRound should contain 12 elements (6 pairs)")
        if let round = viewModel.currentRound {
            for element in Set(round) {
                let count = round.filter { $0 == element }.count
                XCTAssertEqual(count, 2, "Each element in currentRound should appear exactly twice")
            }
        }
        if let round = viewModel.currentRound {
            for element in round {
                XCTAssertTrue(viewModel.allQuestions.contains(element), "All elements in currentRound should come from allQuestions")
            }
        }
    }
}
