//
//  SettingsView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 10.09.25.
//

import SwiftUI
import AVFoundation

struct SettingsView: View {
    @EnvironmentObject var localizableManager: LocalizableManager

    
    @State private var volume: Float = 0.5
    var player = AVAudioPlayer()
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(Constants.Settings.Settings.localized())
                .foregroundStyle(Color.lavenderBlueColor)
                .chalkboardFont(size: 20)
                .bold()
                .multilineTextAlignment(.center)
            Spacer()
            Grid(alignment: .leading) {
                GridRow {
                    Text(Constants.Settings.Sound.localized())
                        .foregroundStyle(Color.lavenderBlueColor)
                        .chalkboardFont(size: 20)
                        .bold()
                        .multilineTextAlignment(.center)
                    Slider(value: $volume, in: 0...1)
                        .tint(Color.lavenderBlueColor)
                        .padding(.horizontal)
                }
                
                GridRow {
                    Text(Constants.Settings.Language.localized())
                        .foregroundStyle(Color.lavenderBlueColor)
                        .chalkboardFont(size: 20)
                        .bold()
                        .multilineTextAlignment(.center)
                    Picker("Dil seçin", selection: $localizableManager.currentLanguage) {
                        ForEach(LanguageTypes.allCases, id: \.self) { lang in
                            Text(lang.displayName)
                                .foregroundStyle(Color.lavenderBlueColor)
                        }
                    }
                    .tint(Color.lavenderBlueColor)
                    .chalkboardFont(size: 20)
                    .pickerStyle(.inline)
                    .padding(.horizontal)
                }
                
            }
            .padding(.horizontal)
            Spacer()
            Image(Constants.Animamals.hippopotamus)
                .resizable()
                .scaledToFit()
                .frame(height: 240)
                .scaleEffect(x: -1)
            Spacer()
        }
        .padding(.all)
        .background{
            LinearGradient(
                gradient: Gradient(colors: [.skyWhisperColor, .cherryMilkColor]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        }
        .cornerRadius(40)
        .overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(Color.lavenderBlueColor, lineWidth: 4)
        )
        .padding(.all, 32)
        
    }
}

#Preview {
    SettingsView()
        .environmentObject(LocalizableManager.shared)
}
