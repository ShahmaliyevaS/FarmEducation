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
        Color(red: 0.85, green: 1.0, blue: 0.85)
    ]
    static let flowers = (1...12).flatMap { number in
        [ "flower\(number)", "flower\(number)" ]
    }
    
    static let balloons = (1...12).flatMap { number in
        [ "ball\(number)", "ball\(number)" ]
    }
    
    static let candies = (1...20).flatMap { number in
        [ "candy\(number)" ]
    }
    
    static let cakesArray = ["appleCake", "cupCake", "dropCake", "lemonCake", "orangeCake",
                        "pineappleCake", "pinkStarCake", "strawberryCake", "yellowStarCake"]
    
    static let vegetables = ["cucumber", "garlic", "carrot", "cabbage", "eggplant",  "potato", "pumpkin", "strawberry", "onion", "watermelon"]
    
    static let cakes = Array(repeating: StaticStore.cakesArray, count: 3).flatMap { $0 }
}
