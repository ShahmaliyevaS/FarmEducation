//
//  GameCardView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 19.05.25.
//

import SwiftUI

struct GameCardView: View {
    @EnvironmentObject var localizableManager: LocalizableManager
    @State var score = Score(recent: 0, recentCount: 0, best: 0, bestCount: 0)
    @Binding var game: GameType?
    var gameType: GameType
    
    var body: some View {
        VStack {
            Spacer()
            Image(gameType.cardDesign.question)
                .resizable()
                .scaledToFit()
                .frame(height: 240)
                .cornerRadius(16)
                .padding(.top)
            
            Text(gameType.rawValue.localized())
                .foregroundStyle(Color.lavenderBlueColor)
                .chalkboardFont(size: 20)
                .bold()
                .multilineTextAlignment(.center)
            Spacer()
            VStack (alignment: .leading) {
                Text(String(format: Constants.UI.lastScore.localized(), score.recent, score.recentCount))
                    .foregroundStyle(Color.lavenderBlueColor)
                    .chalkboardFont(size: 16)
                
                Text(String(format: Constants.UI.bestScore.localized(), score.best, score.bestCount))
                    .foregroundStyle(Color.lavenderBlueColor)
                    .chalkboardFont(size: 16)
            }
            .padding(.bottom)
            Spacer()
            HStack(spacing: 20){
                ForEach(0...1, id: \.self) { i in
                    OptionButtonView(
                        backgroundColor: .clear,
                        cornerColor: .lavenderBlueColor,
                        image: gameType.cardDesign.options[i])
                }
            }
            .padding(.horizontal)
            Spacer()
            
            Button {
                game = gameType
            } label: {
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
        .ignoresSafeArea()
        .padding(.all, 32)
        .onAppear{
            score =  ScoreManager.score.get(for: gameType) ?? Score(recent: 0, recentCount: 0, best: 0, bestCount: 0)
        }
    }
}

#Preview {
    GameCardView(game: .constant(nil), gameType: .whatAnimalsEat)
        .padding(.all)
}


