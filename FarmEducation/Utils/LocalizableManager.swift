//
//  LanguageManager.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 10.09.25.
//

import Foundation
import SwiftUI

class LocalizableManager: ObservableObject {
    static let shared = LocalizableManager()
        
        @AppStorage("currentLanguage")
        private var storedLanguage: LanguageTypes = .english
        
        @Published var currentLanguage: LanguageTypes = .english {
            didSet {
                storedLanguage = currentLanguage
                Bundle.setLanguage(language: currentLanguage.rawValue)
            }
        }
        
        private init() {
            currentLanguage = storedLanguage
            Bundle.setLanguage(language: storedLanguage.rawValue)
        }
    }
