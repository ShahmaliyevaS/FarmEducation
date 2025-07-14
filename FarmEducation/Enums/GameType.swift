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
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .whatAnimalsEat:
            return "What Do Animals Eat?"
        case .whereAnimalsLive:
            return "Where Do Animals Live?"
        case .whichAnimalsShadow:
            return "Whose shadow is this?"
        }
    }
    
}

//Add extensionds for Game Card design
extension GameType {
    var cardDesign: CardDesign {
        switch self {
        case .whatAnimalsEat:
            return CardDesign(question: "cow", options: ["carrot", "egg"])
        case .whereAnimalsLive:
            return CardDesign(question: "forest", options: ["cat", "deer"])
        case .whichAnimalsShadow:
            return CardDesign(question: "blackRabbit", options: ["rabbit", "deer"])
        }
    }
}
