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
        GeometryReader { geo in
            let screenWidth = geo.size.width
            let screenHeight = geo.size.height
            if let round = vm.currentRound {
                VStack {
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
                    Text(gameType.rawValue.localized())
                        .chalkboardFont(size: 20)
                        .bold()
                        .foregroundStyle(Color.lavenderBlueColor)
                        .animation(.spring, value: vm.questionImageAnimation)
                        .padding(.bottom, 32)
                    HStack(spacing: 20) {
                        ForEach(round.options, id: \.self) { option in
                            OptionButtonView(design: getOptionView(option))
                                .frame(height: screenHeight/5)
                                .offset(vm.getOffset(option, width: screenWidth/12, height: screenHeight/10.5))
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
                    GameProgressView(gameType: gameType, correctAnswers: $vm.correctAnswersCount )
                } //Vstack
                .background{
                    Image(round.question)
                        .resizable()
                        .scaledToFill()
                        .overlay {
                            LinearGradient(
                                stops: [
                                    .init(color: .clear, location: 0),
                                    .init(color: Places(rawValue: round.question)?.backgroundColor ?? Color.clear, location: 1)
                                ],
                                startPoint: .center,
                                endPoint: .bottom)
                        }
                        .animation(.smooth, value: vm.questionImageAnimation)
                }
                .ignoresSafeArea()
            } // if statement
            AnimationManager(score: vm.correctAnswersCount)
        } //GeometryReader
        .navigationBarBackButtonHidden(true)
        .onAppear {
            vm.loadQuestions()
        }
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
