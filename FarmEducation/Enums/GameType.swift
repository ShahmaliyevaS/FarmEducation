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
}

extension GameType {
    var cardDesign: CardDesign {
        switch self {
        case .whatAnimalsEat:
            return CardDesign(question: Constants.Animamals.camel, options: [Constants.Meal.pumpkin, Constants.Meal.garlic])
        case .whereAnimalsLive:
            return CardDesign(question: Constants.Background.forest, options: [Constants.Animamals.cat, Constants.Animamals.deer])
        case .whichAnimalsShadow:
            return CardDesign(question: Constants.Animamals.blackAntelope, options: [Constants.Animamals.antelope, Constants.Animamals.deer])
        case .whosePartIsThis:
            return CardDesign(question: Constants.UI.whosePart, options: [Constants.Animamals.crocodile, Constants.Animamals.snake])
        case .whoIsMyPair:
            return CardDesign(question: Constants.Animamals.badger, options: [Constants.Animamals.badger, Constants.Animamals.giraffe])
        }
    }
    
    var progressDesign: [String] {
        switch self {
        case .whatAnimalsEat:
            return StaticStore.vegetables
        case .whereAnimalsLive:
            return StaticStore.animals
        case .whichAnimalsShadow:
            return StaticStore.animals
        case .whosePartIsThis:
            return StaticStore.cakesArray
        case .whoIsMyPair:
            return StaticStore.animals
        }
    }
    
    var carDesign: String {
        switch self {
        case .whatAnimalsEat:
            return Constants.UI.tractor
        case .whereAnimalsLive:
            return Constants.UI.livestockTruck
        case .whichAnimalsShadow:
            return Constants.UI.livestockTruckShadow
        case .whosePartIsThis:
            return Constants.UI.candyCar
        case .whoIsMyPair:
            return Constants.UI.tractor
        }
    }
}
