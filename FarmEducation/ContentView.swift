//
//  ContentView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 19.05.25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab: AnyHashable = GameType.allCases.first!
    @StateObject private var scoreManager = ScoreManager.shared
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selectedTab) {
                ForEach(GameType.allCases, id: \.self) { type in
                    GameCardView(gameType: type, score: scoreManager.score)
                        .tag(type as AnyHashable)
                }
                SettingsView()
                    .tag("setting" as AnyHashable)
            }
            .tabViewStyle(.page(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .ignoresSafeArea()
            .padding(.bottom, -16)
            .padding(.vertical)
            .background{
                LinearGradient(
                    gradient:Gradient(colors: [.cherryMilkColor, .paleSkyColor, .lavenderBlueColor.opacity(0.8) ]),
                    startPoint: .top,
                    endPoint: .bottom)
                .ignoresSafeArea()
            }
        }
        .onAppear {
            if let type = selectedTab as? GameType {
                if let loaded = ScoreManager.shared.get(for: type) {
                    scoreManager.score = loaded
                }
            }
        }
        .onChange(of: selectedTab) {
            if let type = selectedTab as? GameType {
                if let loaded = ScoreManager.shared.get(for: type) {
                    scoreManager.score = loaded
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AudioManager.shared)
        .environmentObject(LocalizableManager.shared)
}
