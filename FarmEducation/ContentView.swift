//
//  ContentView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 19.05.25.
//

import SwiftUI

struct ContentView: View {
    @State private var type: GameType?
    @State private var tabVersion = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView {
                    ForEach(GameType.allCases, id: \.self) { type in
                        GameCardView(game: $type, gameType: type)
                    }
                    SettingsView()
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .ignoresSafeArea()
                .padding(.bottom, -16)
                .padding(.vertical)
            }
            .navigationDestination(item: $type) { game in
                switch game {
                    case .whatAnimalsEat:
                        WhatAnimalsEatView()
                    case .whereAnimalsLive:
                        WhereAnimalsLiveView()
                    case .whichAnimalsShadow:
                        WhichAnimalsShadowView()
                    case .whosePartIsThis:
                        WhosePartIsThisView()
                    case .whoIsMyPair:
                        WhoIsMyPairView()
                }
            }
            .background{
                LinearGradient(
                    gradient:Gradient(colors: [.cherryMilkColor, .paleSkyColor, .lavenderBlueColor.opacity(0.8) ]),
                    startPoint: .top,
                    endPoint: .bottom)
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AudioManager.shared)
        .environmentObject(LocalizableManager.shared)
}
