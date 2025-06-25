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
    case whoEatsThisFood  = "whoEatsThisFood"
    case colorMatching = "colorMatching"     
    
    var id: String { self.rawValue }
    
    var title: String {
        switch self {
        case .whatAnimalsEat:
            return "What Do Animals Eat?"
        case .whoEatsThisFood:
            return "Who Eats This Food?"
        case .colorMatching:
            return "Color Matching"
        }
    }
}

//Add extensionds for Game Card design
extension GameType {
    var cardDesign: CardDesign {
        switch self {
        case .whatAnimalsEat:
            return CardDesign(question: "cow", options: ["carrot", "egg"])
        case .whoEatsThisFood :
            return CardDesign(question: "carrot", options: ["rabbit", "dog"])
        case .colorMatching:
            return CardDesign(question: "cow", options: ["carrot", "egg"])
        }
    }
}
