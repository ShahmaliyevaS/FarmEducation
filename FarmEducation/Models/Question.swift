//
//  Question.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 22.05.25.
//

import Foundation

struct Question: Decodable {
    var id: Int
    var question: String
    var trueAnswer: String
    var falseAnswer: [String]

}
