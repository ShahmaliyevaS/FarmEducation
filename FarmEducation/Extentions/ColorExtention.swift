//
//  ColorExtention.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 22.05.25.
//

import Foundation
import SwiftUI

extension Color {
    static var customRandom: Color {
        let allowedColors: [Color] = [
            .blue.opacity(0.5), .green, .orange, .mint,
            .yellow, .cyan, .teal, .indigo, .purple, .pink
        ]
        return allowedColors.randomElement() ?? .blue
    }
}
