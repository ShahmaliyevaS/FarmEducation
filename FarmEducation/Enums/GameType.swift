//
//  GameType.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 20.05.25.
//

import Foundation
import SwiftUI

enum GameType: String, Codable {
    case whatAnimalsEat = "whatAnimalsEat"
    case whoEatsThisFood  = "whoEatsThisFood"
    case colorMatching = "colorMatching"     
    
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
            return CardDesign(backgroundImage: "farm2", backgroundColor: .green, cornerColor: .yellow, question: "cow", options: ["carrot", "egg"])
        case .whoEatsThisFood :
            return CardDesign(backgroundImage: "farm2", backgroundColor: .yellow, cornerColor: .orange, question: "carrot", options: ["rabbit", "dog"])
        case .colorMatching:
            return CardDesign(backgroundImage: "farm2", backgroundColor: .blue, cornerColor: .black, question: "cow", options: ["carrot", "egg"])
        }
    }
}
