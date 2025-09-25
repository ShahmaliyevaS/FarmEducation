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
    @EnvironmentObject var audio: AudioManager
    
    @State private var volume: Float = 0.5
    
    var body: some View {
        GeometryReader { geo in
            let screenHeight = geo.size.height
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
                        HStack(spacing: 0) {
                            Button(action: {
                                audio.volume = 0
                            }) {
                                Image(systemName: "speaker.slash.fill")
                                    .font(.title)
                                    .foregroundColor(Color.lavenderBlueColor)
                            }
                            Slider(value:  $audio.volume, in: 0...1)
                                .tint(Color.lavenderBlueColor)
                                .padding(.horizontal)
                            Button(action: {
                                audio.volume = 1
                            }) {
                                Image(systemName: "speaker.wave.2.fill")
                                    .font(.title)
                                    .foregroundColor(Color.lavenderBlueColor)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    GridRow {
                        Text(Constants.Settings.Language.localized())
                            .foregroundStyle(Color.lavenderBlueColor)
                            .chalkboardFont(size: 20)
                            .bold()
                            .multilineTextAlignment(.center)
                        Picker("", selection: $localizableManager.currentLanguage) {
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
                    .frame(height: screenHeight/3)
                    .scaleEffect(x: -1)
                Spacer()
            }
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
}

#Preview {
    SettingsView()
        .environmentObject(LocalizableManager.shared)
        .environmentObject(AudioManager.shared)
}
