//
//  WhereAnimalsLive.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 11.07.25.
//

import SwiftUI

struct WhereAnimalsLiveView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var audio: AudioManager
    @StateObject private var vm = QuestionViewModel(.whereAnimalsLive, AudioManager.shared)
    
    var gameType: GameType = .whereAnimalsLive
    
    var body: some View {
        ZStack {
            VStack {
                if let round = vm.currentRound {
                    GeometryReader { geo in
                        let screenWidth = geo.size.width
                        let screenHeight = geo.size.height
                        ZStack (alignment: .topLeading) {
                            Image(round.question)
                                .resizable()
                                .scaledToFit()
                                .overlay {
                                    LinearGradient(
                                        stops: [
                                            .init(color: .clear, location: 0),
                                            .init(color: Places(rawValue: round.question)?.backgroundColor ?? Color.clear, location: 1)
                                        ],
                                        startPoint: .center,
                                        endPoint: .bottom)
                                }
                            VStack {
                                HStack {
                                    Button {
                                        vm.exitGame(dismiss: { dismiss() }, gameType: gameType)
                                    } label: {
                                        ExitView()
                                    }
                                    Spacer()
                                } // Exit button
                                .offset(CGSize(width: 0, height: 40))
                                .frame(width: (geo.size.width.isNaN || geo.size.width < 32) ? 0 : geo.size.width - 32)
                                .padding(.horizontal)
                                
                                Spacer()
                                Text(gameType.rawValue.localized())
                                    .chalkboardFont(size: 20)
                                    .bold()
                                    .foregroundStyle(Color.lavenderBlueColor)
                                    .animation(.spring, value: vm.questionImageAnimation)
                                    .padding(.bottom, 32)
                                HStack(spacing: 20) {
                                    ForEach(round.options, id: \.self) { option in
                                        OptionButtonView(design: getOptionView(option))
                                            .frame(height: 160)
                                            .offset(vm.getOffset(option, width: screenWidth/12, height: screenHeight/11))
                                            .animation(.smooth, value: vm.offsetAnimation)
                                            .overlay {
                                                if vm.isFirstFalseAnswer(option) {
                                                    Image(Constants.UI.falseImage)
                                                        .resizable()
                                                        .scaledToFit()
                                                }
                                            }
                                            .scaleEffect(vm.isSelected(option) && !vm.isFirstFalseAnswer(option) ? 4 : 1)
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
                        .background{
                            Places(rawValue: round.question)?.backgroundColor ?? Color.greenNeonGrassColor
                        }
                    } //GeometryReader
                    .ignoresSafeArea()
                } // end of if statement
            } //VStack
            .navigationBarBackButtonHidden(true)
            .onAppear {
                vm.loadQuestions()
            }
            AnimationManager(score: vm.correctAnswersCount)
        } //ZStack
    }
    
    func getOptionView(_ option: String) -> OptionButtonDesign {
        if vm.isSelected(option) && !vm.isFirstFalseAnswer(option) {
            return OptionButtonDesign(cornerColor: Color.clear, image: vm.isCorrect(option) ? option : Constants.UI.falseImage, shadow: false)
        }
        return OptionButtonDesign(cornerColor: Color.lavenderBlue, image: option)
    }
}

#Preview {
    WhereAnimalsLiveView()
        .environmentObject(AudioManager.shared)
    
}
