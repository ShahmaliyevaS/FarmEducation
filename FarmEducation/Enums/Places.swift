//
//  Places.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 11.07.25.
//

import Foundation
import SwiftUI

enum Places: String {
    case forest
    case home
    case farm
    case desert
    case ocean
    
    var backgroundColor: Color {
        switch self {
        case .forest :
            return Color(Constants.Colors.forest)
        case .home :
            return Color(Constants.Colors.home)
        case .farm :
            return Color(Constants.Colors.farm)
        case .desert :
            return Color(Constants.Colors.desert)
        case .ocean :
            return Color(Constants.Colors.ocean)
        }
    }
}
