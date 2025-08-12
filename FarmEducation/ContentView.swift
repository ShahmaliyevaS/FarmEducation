//
//  ContentView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 19.05.25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedGame: GameType?
    
    var body: some View {
        NavigationStack {
            ZStack {
                TabView {
                    ForEach(GameType.allCases) {
                        type in
                        GameCardView(gameType: type, selectedGame: $selectedGame)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .ignoresSafeArea()
                .padding(.bottom, -16)
                .padding(.vertical)
            }
            .navigationDestination(item: $selectedGame) { game in
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
                    gradient:Gradient(colors: [.cherryMilkColor, .sunGlowColor, .skyWhisperColor]),
                    startPoint: .top,
                    endPoint: .bottom)
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    ContentView()
}
