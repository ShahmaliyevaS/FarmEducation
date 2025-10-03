//
//  WhoseTailIsThisView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 16.07.25.
//

import SwiftUI

struct WhosePartIsThisView: View {
    let gameType: GameType = .whosePartIsThis
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var audio: AudioManager
    
    @StateObject var vm = WhosePartIsThisViewModel(.whosePartIsThis, AudioManager.shared)
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 5)
    
    var data = Array(repeating: "", count: 25)
    
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
                    ZStack {
                        Image(round.question)
                            .resizable()
                            .scaledToFit()
                            .shadow(radius: 10)
                            .frame( maxWidth: max(0, screenWidth - 44),
                                    maxHeight: max(0, screenHeight / 2.1))
                            .animation(.snappy, value: vm.questionImageAnimation)
                            .opacity(vm.isHidden() ? 0 : 1)
                            .animation(.smooth, value: vm.isHidden())
                        
                        LazyVGrid(columns: columns, spacing: 0) {
                            ForEach(Array(data.enumerated()), id: \.offset) { index, item in
                                Rectangle()
                                    .fill(vm.selectedParts.contains(index) ? .clear : StaticStore.pastelColors.randomElement()!)
                                    .frame(height: screenHeight / 10)
                                    .border(Color.lavenderBlueColor)
                                    .animation(.smooth, value: vm.selectedParts.last != index)
                                    .onTapGesture {
                                        vm.setSelectPart(index)
                                    }
                            }
                        }
                        .cornerRadius(44)
                        .overlay(
                            RoundedRectangle(cornerRadius: 44)
                                .stroke(Color.lavenderBlueColor, lineWidth: 4)
                        )
                        .padding(.horizontal)
                        if vm.hidden {
                            Image(round.question)
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: screenWidth-44, maxHeight: screenHeight/2.1)
                                .shadow(radius: 10)
                        }
                    }
                    Text(gameType.rawValue.localized())
                        .chalkboardFont(size: 20)
                        .bold()
                        .foregroundStyle(Color.lavenderBlueColor)
                        .animation(.spring, value: vm.questionImageAnimation)
                        .padding(.bottom, 24)
                    
                    HStack(spacing: 20) {
                        ForEach(round.options, id: \.self) { option in
                            OptionButtonView(design: getOptionView(option))
                                .frame(height: screenHeight/5)
                                .offset(vm.getOffset(option, width: screenWidth/4.4, height: screenHeight/3.4))
                                .animation(.smooth, value: vm.offsetAnimation)
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
                    GameProgressView(gameType: gameType, correctAnswers: $vm.correctAnswersCount )
                } //VStack
                .navigationBarBackButtonHidden(true)
                .background {
                    LinearGradient(
                        gradient: Gradient(colors: [.skyWhisperColor, .cherryMilkColor]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
            } // if statement
            AnimationManager(score: vm.correctAnswersCount)
        } //GeometryReader
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

#Preview {
    WhosePartIsThisView()
        .environmentObject(AudioManager.shared)
    
}
