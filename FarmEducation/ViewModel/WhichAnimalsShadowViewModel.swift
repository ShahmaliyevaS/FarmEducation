//
//  WhichAnimalsShadowViewModel.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 21.09.25.
//

import Foundation
import SwiftUI

class WhichAnimalsShadowViewModel: QuestionViewModel {
    @Published var hidden: Bool = false
    
    func isHidden() -> Bool{
        return hidden
    }
    
    override func innerHandleAnswer(_ option: String) {
        if isCorrect(option) {
            hidden = true
        }
    }
    
    override func innerResertRoundStates() {
        hidden = false
    }
}
