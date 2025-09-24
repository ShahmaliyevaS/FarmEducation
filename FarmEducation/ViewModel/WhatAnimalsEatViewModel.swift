//
//  WhatAnimalsEatViewModel.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 22.09.25.
//

import Foundation
import SwiftUI

class WhatAnimalsEatViewModel: QuestionViewModel {
    func getOptionView(_ option: String) -> OptionButtonDesign {
        if isSelected(option) && !isFirstFalseAnswer(option) {
            if isCorrect(option) {
                return OptionButtonDesign(backgroundColor: Color.freshLawnColor.opacity(0.2), cornerColor: Color.freshLawnColor, image: Constants.UI.rightImage)
            } else {
                return OptionButtonDesign(backgroundColor: Color.brickRedColor.opacity(0.2), cornerColor: Color.brickRedColor, image: Constants.UI.falseImage)
            }  
        }
        return OptionButtonDesign(cornerColor: Color.lavenderBlueColor, image: option)
    }
}
