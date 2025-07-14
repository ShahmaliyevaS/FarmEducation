//
//  FarmData.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 08.07.25.
//

import Foundation

struct FarmData {
    static var whatAnimalsEatQuestions: [Question] = JSONLoader.loadQuestions(from: GameType.whatAnimalsEat.rawValue)
    static var whereAnimalsLiveQuestions: [Question] = JSONLoader.loadQuestions(from: GameType.whereAnimalsLive.rawValue)
    static var whichAnimalsShadow: [Question] = JSONLoader.loadQuestions(from: GameType.whichAnimalsShadow.rawValue)
}
