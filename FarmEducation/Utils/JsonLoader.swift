//
//  JSONLoader.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 22.05.25.
//

import Foundation

class JSONLoader {
    static func loadQuestions(from fileName: String) -> [Question] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let questions = try? JSONDecoder().decode([Question].self, from: data) else {
            return []
        }
        return questions
    }
}
