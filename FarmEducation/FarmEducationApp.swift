//
//  FarmEducationApp.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 19.05.25.
//

import SwiftUI

@main
struct FarmEducationApp: App {
    @EnvironmentObject var localizableManager: LocalizableManager
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(LocalizableManager.shared)
        }
    }
}
