//
//  WhosePartIsThisViewModel.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 21.09.25.
//

import Foundation
import SwiftUI

class WhosePartIsThisViewModel: QuestionViewModel {
    @Published var hidden: Bool = false
    @Published var selectedParts: [Int] = [4]
    
    func setSelectPart(_ index: Int) {
        if selectedParts.count == 1 && selectedParts.last != index {
            selectedParts.append(index)
        }
    }
    
    func isHidden() -> Bool{
        return hidden
    }
    
    override func handleAnswer(_ option: String) {
        super.handleAnswer(option)
        if isCorrect(option) {
            hidden = true
        }
    }
    
    override func resetRoundStates() {
        super.resetRoundStates()
        hidden = false
        selectedParts = [4]
    }
}
