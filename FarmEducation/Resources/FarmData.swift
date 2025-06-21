//
//  FarmData.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 03.06.25.
//

import Foundation

struct FarmData {
    static var whatAnimalsEatQuestions: [Question] = JSONLoader.loadQuestions(from: GameType.whatAnimalsEat.rawValue)
    static var whoEatsThisFoodQuestions: [Question] = JSONLoader.loadQuestions(from: GameType.whoEatsThisFood.rawValue)
    static var colorMatchingQuestions: [Question] = []
}
