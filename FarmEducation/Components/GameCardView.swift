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
    var gradientColors: [Color] = [.sunGlowColor, .freshLimeColor, .electricAvocadoColor, .greenNeonGrassColor, ]
    var body: some View {
        VStack {
            Spacer()
            Image(gameType.cardDesign.question)
                .resizable()
                .scaledToFit()
                .frame(height: 240)
                .cornerRadius(16)
                .padding(.top)
            
            Text(gameType.title.capitalized)
                .foregroundStyle(Color.lavenderBlueColor)
                .chalkboardFont(size: 32)
                .multilineTextAlignment(.center)
            Spacer()
            VStack (alignment: .leading) {
                Text("Last Score: \(score.recent) from \(score.recentCount)")
                    .foregroundStyle(Color.lavenderBlueColor)
                    .chalkboardFont(size: 20)
                
                Text("Best Score: \(score.best) from \(score.bestCount)")
                    .foregroundStyle(Color.lavenderBlueColor)
                    .chalkboardFont(size: 20)
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
                selectedGame = gameType
            } label: {
                Text("Play")
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
    GameCardView(gameType: .whatAnimalsEat, selectedGame: .constant(nil))
        .padding(.all)
}
