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
    @Published var selectedParts: [Int] = [7]
    
    
    func setSelectPart(_ index: Int) {
        if selectedParts.count < 2 && !selectedParts.contains(index) {
            selectedParts.append(index)
        }
    }
    
    func isHidden() -> Bool{
        return hidden
    }
    
    override func innerHandleAnswer(_ option: String) {
        if isCorrect(option) {
            hidden = true
        }
    }
    
    override func innerResertRoundStates() {
        selectedParts = [7]
        hidden = false
    }
}
