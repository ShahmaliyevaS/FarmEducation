//
//  Places.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 11.07.25.
//

import Foundation
import SwiftUI

enum Places: String {
    case forest = "forest"
    case home = "home"
    case farm = "farm"
    case desert = "desert"
    case ocean = "ocean"
    
    var backgroundColor: Color {
        switch self {
        case .forest :
            return Color("forestColor")
        case .home :
            return Color("homeColor")
        case .farm :
            return Color("farmColor")
        case .desert :
            return Color("desertColor")
        case .ocean :
            return Color("oceanColor")
        }
    }
}
