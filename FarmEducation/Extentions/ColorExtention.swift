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

extension Color {
    static let greenNeonGrassColor = Color("greenNeonGrassColor")
    static let skyBlueColor = Color("skyBlueColor")
    static let sunGlowColor = Color("sunGlowColor")
    static let burntOrangeColor = Color("burntOrangeColor")
    static let freshLawnColor = Color("freshLawnColor")
    static let brickRedColor = Color("brickRedColor")
    static let lavenderBlueColor = Color("lavenderBlueColor")
    static let paleSkyColor = Color("paleSkyColor")
    static let crystalBlueColor = Color("crystalBlueColor")
    static let skyWhisperColor = Color("skyWhisperColor")
    static let cherryMilkColor = Color("cherryMilkColor")
    static let freshLimeColor = Color("freshLimeColor")
    static let electricAvocadoColor = Color("electricAvocadoColor")
    static let oceanColor = Color("oceanColor")
}
