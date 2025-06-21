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
            ZStack{
                Color.blue.ignoresSafeArea().opacity(0.3)
                
                TabView {
                    
                    GameCardView(gameType: .whatAnimalsEat, selectedGame: $selectedGame)
                    GameCardView(gameType: .whoEatsThisFood, selectedGame: $selectedGame)
                    GameCardView(gameType: .colorMatching, selectedGame: $selectedGame)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .ignoresSafeArea()
                .padding(.bottom, -16)
                .padding(.vertical)
            }
            .navigationDestination(item: $selectedGame) { game in
                AnimalFoodMatchView(gameType: game)
            }
        }
    }
}

#Preview {
    ContentView()
}
