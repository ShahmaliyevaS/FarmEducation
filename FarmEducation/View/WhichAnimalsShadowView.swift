//
//  WhichAnimalsShadow.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 12.07.25.
//

import SwiftUI
import CoreImage

struct WhichAnimalsShadowView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var audio: AudioManager
    @StateObject var vm = WhichAnimalsShadowViewModel(.whichAnimalsShadow, AudioManager.shared)
    
    var gameType: GameType = .whichAnimalsShadow
    
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
                                        ScoreManager.shared.saveScore(gameType, askedQuestionsCount: vm.getAskedQuestionCount(), correctAnswersCount: vm.correctAnswersCount)
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
                                    .colorMultiply(.black)
                                    .frame(height: screenHeight/3)
                                    .shadow(radius: 10)
                                    .scaleEffect(x: -1, y: 1, anchor: .center)
                                    .opacity(vm.isHidden() ? 0 : 1)
                                    .animation(.snappy, value: vm.questionImageAnimation)
                                    .animation(.smooth(duration: TimeInterval(1.6)), value: vm.isHidden())
                                
                                Text(gameType.rawValue.localized())
                                    .chalkboardFont(size: 20)
                                    .bold()
                                    .foregroundStyle(Color.lavenderBlueColor)
                                    .animation(.spring, value: vm.questionImageAnimation)
                                    .padding(.bottom, 32)
                                
                                HStack(spacing: 20) {
                                    ForEach(round.options, id: \.self) { option in
                                        OptionButtonView(design: vm.getOptionView(option))
                                            .frame(height: 160)
                                            .offset(vm.getOffset(option, width: -screenWidth/16, height: screenHeight/13))
                                            .scaleEffect(vm.isSelected(option) && !vm.isFirstFalseAnswer(option) ? 5 : 1)
                                            .scaleEffect(x: vm.isSelected(option) ? -1 : 1, anchor: .center)
                                            .animation(.smooth, value: vm.offsetAnimation)
                                            .overlay {
                                                if vm.isFirstFalseAnswer(option) {
                                                    Image(Constants.UI.falseImage)
                                                        .resizable()
                                                        .scaledToFit()
                                                }
                                            }
                                            .onTapGesture {
                                                vm.handleAnswer(option)
                                            }
                                    }
                                } //options HStack
                                .padding(.horizontal)
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
    WhichAnimalsShadowView()
        .environmentObject(AudioManager.shared)
    
}
