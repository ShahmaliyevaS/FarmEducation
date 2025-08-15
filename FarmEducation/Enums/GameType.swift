//
//  GameType.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 20.05.25.
//

import Foundation
import SwiftUI

enum GameType: String, Codable, CaseIterable, Identifiable {
    case whatAnimalsEat
    case whereAnimalsLive
    case whichAnimalsShadow
    case whosePartIsThis
    case whoIsMyPair
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .whatAnimalsEat:
            return Constants.whatAnimalsEat
        case .whereAnimalsLive:
            return Constants.whereAnimalsLive
        case .whichAnimalsShadow:
            return Constants.whichAnimalsShadow
        case .whosePartIsThis:
            return Constants.whosePartIsThis
        case .whoIsMyPair:
            return Constants.whoIsMyPair
        }
    }
}

extension GameType {
    var cardDesign: CardDesign {
        switch self {
        case .whatAnimalsEat:
            return CardDesign(question: Constants.camel, options: [Constants.pumpkin, Constants.garlic])
        case .whereAnimalsLive:
            return CardDesign(question: Constants.forest, options: [Constants.cat, Constants.deer])
        case .whichAnimalsShadow:
            return CardDesign(question: Constants.blackAntelope, options: [Constants.antelope, Constants.deer])
        case .whosePartIsThis:
            return CardDesign(question: Constants.whosePart, options: [Constants.crocodile, Constants.snake])
        case .whoIsMyPair:
            return CardDesign(question: Constants.badger, options: [Constants.badger, Constants.giraffe])
        }
    }
}
