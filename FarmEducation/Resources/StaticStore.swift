//
//  StaticStore.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 11.08.25.
//

import Foundation
import SwiftUI

struct StaticStore {
    static let brightColors: [Color] = [
        Color(red: 102/255, green: 255/255, blue: 0/255),
        Color(red: 25/255, green: 116/255, blue: 210/255),
        Color(red: 8/255, green: 232/255, blue: 222/255),
        Color(red: 255/255, green: 240/255, blue: 0/255),
        Color(red: 255/255, green: 170/255, blue: 29/255),
        Color(red: 255/255, green: 0/255, blue: 127/255),
        Color(red: 102/255, green: 255/255, blue: 0/255),
        Color(red: 25/255, green: 116/255, blue: 210/255),
        Color(red: 8/255, green: 232/255, blue: 222/255),
    ]
    
    static let pastelColors: [Color] = [
        Color(red: 1.0, green: 0.8, blue: 0.8),
        Color(red: 0.8, green: 1.0, blue: 0.8),
        Color(red: 0.8, green: 0.8, blue: 1.0),
        Color(red: 1.0, green: 1.0, blue: 0.8),
        Color(red: 1.0, green: 0.85, blue: 0.7),
        Color(red: 0.7, green: 1.0, blue: 0.9),
        Color(red: 1.0, green: 0.85, blue: 0.9),
        Color(red: 0.9, green: 0.8, blue: 1.0),
        Color(red: 0.85, green: 1.0, blue: 0.85),
        Color(red: 0.95, green: 0.95, blue: 0.75),
        Color(red: 0.75, green: 0.95, blue: 0.95),
        Color(red: 0.95, green: 0.75, blue: 0.85),
        Color(red: 0.85, green: 0.75, blue: 0.95),
        Color(red: 0.95, green: 0.9, blue: 0.75),
        Color(red: 0.75, green: 0.85, blue: 0.95),
        Color(red: 0.9, green: 0.95, blue: 0.75)
    ]
    static let flowers = (1...12).flatMap { number in
        [ "\(Constants.UI.flower)\(number)", "\(Constants.UI.flower)\(number)" ]
    }
    
    static let balloons = (1...12).flatMap { number in
        [ "\(Constants.UI.ball)\(number)", "\(Constants.UI.ball)\(number)" ]
    }
    
    static let candies = (1...20).flatMap { number in
        [ "\(Constants.UI.candy)\(number)" ]
    }
    
    static let cakesArray = [Constants.Cakes.yellowStarCake, Constants.Cakes.appleCake, Constants.Cakes.cupCake, Constants.Cakes.dropCake, Constants.Cakes.lemonCake, Constants.Cakes.orangeCake, Constants.Cakes.pineappleCake, Constants.Cakes.pinkStarCake, Constants.Cakes.strawberryCake, Constants.Cakes.yellowStarCake]
    
    static let vegetables = [Constants.Meal.cucumber, Constants.Meal.garlic, Constants.Meal.carrot, Constants.Meal.cabbage, Constants.Meal.eggplant,  Constants.Meal.potato, Constants.Meal.pumpkin, Constants.Meal.strawberry, Constants.Meal.onion, Constants.Meal.watermelon]
    
    static let animals = [Constants.Animamals.cow, Constants.Animamals.bear, Constants.Animamals.crocodile, Constants.Animamals.elephant, Constants.Animamals.fox, Constants.Animamals.giraffe, Constants.Animamals.hedgehog, Constants.Animamals.kangaroo, Constants.Animamals.lion, Constants.Animamals.panda]
    
    static let cakes = Array(repeating: StaticStore.cakesArray, count: 3).flatMap { $0 }
}
