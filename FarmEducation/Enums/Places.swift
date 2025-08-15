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
            return Color(Constants.forestColor)
        case .home :
            return Color(Constants.homeColor)
        case .farm :
            return Color(Constants.farmColor)
        case .desert :
            return Color(Constants.desertColor)
        case .ocean :
            return Color(Constants.oceanColor)
        }
    }
}
