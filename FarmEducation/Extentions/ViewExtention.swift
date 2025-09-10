//
//  ViewExtention.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 24.06.25.
//

import SwiftUI

extension View {
    func chalkboardFont(size: CGFloat) -> some View {
        self.font(.custom("ChalkboardSE-Regular", size: size))
    }
}

extension String {
    func localized() -> String {
        return Bundle.localizedBundle().localizedString(forKey: self, value: nil, table: nil)
    }
}

extension Bundle {
    private static var bundle: Bundle!
    
    static func setLanguage(language: String) {
        let path = Bundle.main.path(forResource: language, ofType: "lproj")
        bundle = path != nil ? Bundle(path: path!) : Bundle.main
    }
    
    static func localizedBundle() -> Bundle {
        return bundle ?? Bundle.main
    }
}
