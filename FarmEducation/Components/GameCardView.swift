//
//  GameCardView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 19.05.25.
//

import SwiftUI

struct GameCardView: View {
    
    var gameType: GameType
    @Binding var selectedGame: GameType?
    @State var score = Score(recent: 0, recentCount: 0, best: 0, bestCount: 0)
    
    var body: some View {
        VStack {
            Spacer()
            Image(gameType.cardDesign.question)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .padding(.top)
            
            Text(gameType.cardDesign.question.capitalized)
                .foregroundStyle(gameType.cardDesign.cornerColor)
                .font(.custom("ChalkboardSE-Regular", size: 28))
            Spacer()
            VStack (alignment: .leading) {
                Text("Last Score: \(score.recent) from \(score.recentCount)")
                    .foregroundStyle(Color.customRandom)
                .font(.custom("ChalkboardSE-Regular", size: 14))
            
                Text("Best Score: \(score.best) from \(score.bestCount)")
                .foregroundStyle(Color.customRandom)
                .font(.custom("ChalkboardSE-Regular", size: 14))
            }
            .padding(.bottom)
            Spacer()
            HStack(spacing: 20){
                OptionButtonView(backgroundColor: gameType.cardDesign.backgroundColor.opacity(0.6),
                                 cornerColor: gameType.cardDesign.cornerColor, option: gameType.cardDesign.options[0])
                OptionButtonView(backgroundColor: gameType.cardDesign.backgroundColor.opacity(0.6),
                                 cornerColor: gameType.cardDesign.cornerColor, option: gameType.cardDesign.options[1])
            }
            .padding(.horizontal)
            Spacer()
            
            Button {
                selectedGame = gameType
            } label: {
                Text("Play")
                    .frame(width: 200)
                    .foregroundStyle(gameType.cardDesign.cornerColor)
                    .font(.custom("ChalkboardSE-Regular", size: 28))
                    .padding(.vertical, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(gameType.cardDesign.backgroundColor.opacity(0.6) // arxa fon
                                 )
                            .overlay(
                                RoundedRectangle(cornerRadius: 16)
                                    .stroke(gameType.cardDesign.cornerColor, lineWidth: 4)
                            )
                    )
            }
            Spacer()
        } //VStack
        .padding(.all)
        .background{
            Image(gameType.cardDesign.backgroundImage)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .fill(gameType.cardDesign.backgroundColor.opacity(0.3))
                )
        }
        .cornerRadius(40)
        .overlay(
            RoundedRectangle(cornerRadius: 40)
                .stroke(gameType.cardDesign.cornerColor, lineWidth: 4)
        )
        .ignoresSafeArea()
        .padding(.all, 32)
        .onAppear{
            score =  ScoreManager.score.get(for: gameType) ?? Score(recent: 0, recentCount: 0, best: 0, bestCount: 0)
        }
    }
}

#Preview {
    GameCardView(gameType: .whatAnimalsEat, selectedGame: .constant(nil))
        .padding(.all)
}
