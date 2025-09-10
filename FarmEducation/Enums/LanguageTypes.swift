//
//  LanguageTypes.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 10.09.25.
//

import Foundation

enum LanguageTypes: String, CaseIterable, RawRepresentable {
    case english = "en"
    case arabic = "ar"
    case azerbaijani = "az"
    case chinese = "zh-Hans"
    case german = "de"
    case japanese = "ja"
    case french = "fr"
    case korean = "ko"
    case spanish = "es"
    case russinan = "ru"
    case turkish = "tr"

    var displayName: String {
        switch self {
        case .english: return "English"
        case .arabic: return "عربي"
        case .french: return "Français"
        case .russinan: return "Русский"
        case .azerbaijani: return "Azərbaycan"
        case .chinese: return "中文"
        case .german: return "Deutsch"
        case .japanese: return "日本語"
        case .korean: return "한국어"
        case .spanish: return "Español"
        case .turkish: return "Türkçe"
        }
    }
}
