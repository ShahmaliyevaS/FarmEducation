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
    @StateObject var vm = WhatAnimalsEatViewModel(.whatAnimalsEat, AudioManager.shared)
    
    var gameType: GameType = .whatAnimalsEat
    
    var body: some View {
        ZStack {
            VStack {
                if let round = vm.currentRound {
                    GeometryReader { geo in
                        let screenWidth = geo.size.width
                        let screenHeight = geo.size.height
                        ZStack (alignment: .topLeading) {
                            Image(Constants.Background.farm)
                                .resizable()
                                .scaledToFit()
                                .overlay {
                                    LinearGradient(
                                        stops: [
                                            .init(color: .clear, location: 0),
                                            .init(color: .greenNeonGrassColor, location: 1)
                                        ],
                                        startPoint: .center,
                                        endPoint: .bottom)
                                }
                            VStack {
                                HStack {
                                    Button {
                                        ScoreManager.shared.saveScore(
                                            gameType,
                                            askedQuestionsCount: vm.getAskedQuestionCount(),
                                            correctAnswersCount: vm.correctAnswersCount)
                                        dismiss()
                                    } label: {
                                        ExitView()
                                    }
                                    Spacer()
                                } // Exit button
                                .offset(CGSize(width: 0, height: 40))
                                .frame(width: (geo.size.width.isNaN || geo.size.width < 32) ? 0 : geo.size.width - 32)
                                .padding(.horizontal)
                                
                                Spacer()
                                Image(round.question)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 300)
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
                                        OptionButtonView(design: vm.getOptionView(option))
                                            .frame(height: 160)
                                            .offset(vm.getOffset(option, width: screenWidth/5.1, height: screenHeight/4))
                                            .animation(.bouncy, value: vm.offsetAnimation)
                                            .overlay {
                                                if vm.isFirstFalseAnswer(option) {
                                                    Image(Constants.UI.falseImage)
                                                        .resizable()
                                                        .scaledToFit()
                                                }
                                            }
                                            .scaleEffect(vm.isSelected(option) && !vm.isFirstFalseAnswer(option) ? 1.6 : 1)
                                            .onTapGesture {
                                                vm.handleAnswer(option)
                                            }
                                    }
                                } //options HStack
                                .padding(.horizontal)
                                .padding(.bottom, 20)
                                .ignoresSafeArea()
                                
                                GameProgressView(gameType: gameType, correctAnswers: $vm.correctAnswersCount )
                            }
                            .padding(6.0)
                            .frame(maxWidth: screenWidth, maxHeight: screenHeight)
                        }
                    } //GeometryReader
                    .ignoresSafeArea()
                } // end of if statement
            } //VStack
            .navigationBarBackButtonHidden(true)
            .background{
                Color.greenNeonGrassColor
                    .ignoresSafeArea()
            }
            .onAppear {
                vm.loadQuestions()
            }
            AnimationManager(score: vm.correctAnswersCount)
        } //ZStack
    }
}

#Preview {
    WhatAnimalsEatView()
        .environmentObject(AudioManager.shared)
}
