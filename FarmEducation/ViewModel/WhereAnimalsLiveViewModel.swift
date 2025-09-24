//
//  WhereAnimalsLiveViewModel.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 22.09.25.
//

import Foundation
import SwiftUI

class WhereAnimalsLiveViewModel: QuestionViewModel {
    func getOptionView(_ option: String) -> OptionButtonDesign {
        if isSelected(option) && !isFirstFalseAnswer(option) {
            return OptionButtonDesign(cornerColor: Color.clear, image: isCorrect(option) ? option : Constants.UI.falseImage, shadow: false)
        }
        return OptionButtonDesign(cornerColor: Color.lavenderBlue, image: option)
    }
}
