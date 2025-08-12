//
//  GameType.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 20.05.25.
//

import Foundation
import SwiftUI

enum GameType: String, Codable, CaseIterable, Identifiable {
    case whatAnimalsEat = "whatAnimalsEat"
    case whereAnimalsLive = "whereAnimalsLive"
    case whichAnimalsShadow = "whichAnimalsShadow"
    case whosePartIsThis = "whosePartIsThis"
    case whoIsMyPair = "whoIsMyPair"
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .whatAnimalsEat:
            return "What does this animal eat?"
        case .whereAnimalsLive:
            return "Which animal lives here?"
        case .whichAnimalsShadow:
            return "Whose shadow is this?"
        case .whosePartIsThis:
            return "Whose body part is this?"
        case .whoIsMyPair:
            return "Match the Animals"
        }
    }
}

extension GameType {
    var cardDesign: CardDesign {
        switch self {
        case .whatAnimalsEat:
            return CardDesign(question: "cow", options: ["carrot", "egg"])
        case .whereAnimalsLive:
            return CardDesign(question: "forest", options: ["cat", "deer"])
        case .whichAnimalsShadow:
            return CardDesign(question: "blackAntelope", options: ["antelope", "deer"])
        case .whosePartIsThis:
            return CardDesign(question: Constants.whosePart, options: [Constants.crocodile, Constants.snake])
        case .whoIsMyPair:
            return CardDesign(question: "cow", options: ["carrot", "egg"])
        }
    }
}
