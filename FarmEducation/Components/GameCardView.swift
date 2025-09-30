//
//  GameCardView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 19.05.25.
//

import SwiftUI

struct GameCardView: View {
    @EnvironmentObject var localizableManager: LocalizableManager
    var score: Score
    var gameType: GameType
    
    init(gameType: GameType, score: Score) {
        self.gameType = gameType
        self.score = score
    }
    
    var body: some View {
        GeometryReader { geo in
            let screenHeight = geo.size.height
            VStack {
                Spacer()
                Image(gameType.cardDesign.question)
                    .resizable()
                    .scaledToFit()
                    .frame(height: screenHeight/3)
                    .cornerRadius(16)
                    .padding(.top)
                
                Text(gameType.rawValue.localized())
                    .foregroundStyle(Color.lavenderBlueColor)
                    .chalkboardFont(size: 20)
                    .bold()
                    .multilineTextAlignment(.center)
                Spacer()
                Text(String(format: Constants.UI.lastScore.localized(), score.recent, score.recentCount))
                    .foregroundStyle(Color.lavenderBlueColor)
                    .chalkboardFont(size: 16)
                    .frame(alignment: .leading)
                
                Text(String(format: Constants.UI.bestScore.localized(), score.best, score.bestCount))
                    .foregroundStyle(Color.lavenderBlueColor)
                    .chalkboardFont(size: 16)
                    .frame(alignment: .leading)
                Spacer()
                HStack(spacing: 20){
                    ForEach(0...1, id: \.self) { i in
                        OptionButtonView(design: OptionButtonDesign(backgroundColor: .clear, cornerColor: .lavenderBlueColor, image: gameType.cardDesign.options[i]))
                    }
                }
                .frame(height: screenHeight/4)
                .padding(.horizontal)
                Spacer()
                
                NavigationLink(destination: destinationView(for: gameType)) {
                    Text(Constants.UI.play.localized())
                        .frame(width: 200)
                        .foregroundStyle(Color.lavenderBlueColor)
                        .chalkboardFont(size: 28)
                        .padding(.vertical, 10)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.clear)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.lavenderBlueColor, lineWidth: 4)
                                )
                        )
                        .shadow(color: .black.opacity(0.5), radius: 10, x: 5, y: 5)
                }
                Spacer()
            } //VStack
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
        }
        .padding(.all, 32)
    }
    
    @ViewBuilder
    private func destinationView(for gameType: GameType) -> some View {
        switch gameType {
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
}

#Preview {
    GameCardView(gameType: .whereAnimalsLive, score: Score(recent: 0, recentCount: 0, best: 0, bestCount: 0))
        .padding(.all)
}


