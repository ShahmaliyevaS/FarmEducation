//
//  FarmData.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 08.07.25.
//

import Foundation

struct DataLoader {
    static var whatAnimalsEatQuestions: [Question] = JSONLoader.loadQuestions(from: GameType.whatAnimalsEat.rawValue)
    static var whereAnimalsLiveQuestions: [Question] = JSONLoader.loadQuestions(from: GameType.whereAnimalsLive.rawValue)
    static var whichAnimalsShadowQuestions: [Question] = JSONLoader.loadQuestions(from: GameType.whichAnimalsShadow.rawValue)
    static var whosePartIsThisQuestions: [Question] = JSONLoader.loadQuestions(from: GameType.whosePartIsThis.rawValue)
    static var whoIsMYpair: [String] = JSONLoader.loadQuestions(from: GameType.whoIsMyPair.rawValue)
}
