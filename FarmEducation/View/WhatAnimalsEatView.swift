//
//  WhatAnimalsEatView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 19.05.25.
//

import SwiftUI

struct WhatAnimalsEatView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var audio: AudioManager
    @StateObject var vm = QuestionViewModel(.whatAnimalsEat, AudioManager.shared)
    
    var gameType: GameType = .whatAnimalsEat
    
    var body: some View {
        GeometryReader { geo in
            let screenWidth = geo.size.width
            let screenHeight = geo.size.height
            VStack {
                if let round = vm.currentRound {
                    HStack {
                        Button {
                            vm.exitGame(dismiss: { dismiss() }, gameType: gameType)
                        } label: {
                            ExitView()
                                .frame(height: screenHeight/15)
                        }
                        Spacer()
                    } // Exit button
                    .padding(.top, 24)
                    .padding(.leading, 8)
                    
                    Spacer()
                    Image(round.question)
                        .resizable()
                        .scaledToFit()
                        .frame(height: screenHeight/3)
                        .shadow(radius: 10)
                        .animation(.snappy, value: vm.questionImageAnimation)
                    Text(gameType.rawValue.localized())
                        .chalkboardFont(size: 20)
                        .bold()
                        .foregroundStyle( Color.lavenderBlueColor)
                        .animation(.spring, value: vm.questionImageAnimation)
                        .padding(.bottom, 20)
                    HStack(spacing: 20) {
                        ForEach(round.options, id: \.self) { option in
                            OptionButtonView(design: getOptionView(option))
                                .frame(height: screenHeight/5)
                                .offset(vm.getOffset(option, width: screenWidth/4.4, height: screenHeight/4))
                                .animation(.bouncy, value: vm.offsetAnimation)
                                .overlay {
                                    if vm.isFirstFalseAnswer(option) {
                                        Image(Constants.UI.falseImage)
                                            .resizable()
                                            .scaledToFit()
                                    }
                                }
                                .scaleEffect(vm.isSelected(option) && !vm.isFirstFalseAnswer(option) ? 1.4 : 1)
                                .onTapGesture {
                                    vm.handleAnswer(option)
                                }
                        }
                    } //options HStack
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    .ignoresSafeArea()
                    
                    GameProgressView(gameType: gameType, correctAnswers: $vm.correctAnswersCount )
                } // if statement
            } // Vstack
            .background {
                Image(Constants.Background.farm)
                    .resizable()
                    .scaledToFill()
                    .overlay {
                        LinearGradient(
                            stops: [
                                .init(color: .clear, location: 0),
                                .init(color: .greenNeonGrassColor, location: 1)
                            ],
                            startPoint: .center,
                            endPoint: .bottom)
                    }
            }
            AnimationManager(score: vm.correctAnswersCount)
        } //GeometryReader
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
    
    func getOptionView(_ option: String) -> OptionButtonDesign {
        if vm.isSelected(option) && !vm.isFirstFalseAnswer(option) {
            if vm.isCorrect(option) {
                return OptionButtonDesign(backgroundColor: Color.freshLawnColor.opacity(0.2), cornerColor: Color.freshLawnColor, image: Constants.UI.rightImage)
            } else {
                return OptionButtonDesign(backgroundColor: Color.brickRedColor.opacity(0.2), cornerColor: Color.brickRedColor, image: Constants.UI.falseImage)
            }
        }
        return OptionButtonDesign(cornerColor: Color.lavenderBlueColor, image: option)
    }
}

#Preview("iPhone 15 Pro") {
    WhatAnimalsEatView()
        .environmentObject(AudioManager.shared)
        .previewDevice("iPhone 15 Pro")
}
