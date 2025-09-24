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
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
    
    var data = Array(repeating: "", count: 9)
    
    var body: some View {
        ZStack {
            VStack {
                if let round = vm.currentRound {
                    GeometryReader { geo in
                        let screenWidth = geo.size.width
                        let screenHeight = geo.size.height
                        ZStack (alignment: .topLeading) {
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
                                ZStack {
                                    Image(round.question)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 400)
                                        .shadow(radius: 10)
                                        .animation(.snappy, value: vm.questionImageAnimation)
                                        .opacity(vm.isHidden() ? 0 : 1)
                                        .animation(.smooth(duration: TimeInterval(0.8)), value: vm.isHidden())
                                    
                                    LazyVGrid(columns: columns, spacing: 0) {
                                        ForEach(Array(data.enumerated()), id: \.offset) { index, item in
                                            Rectangle()
                                                .fill(vm.selectedParts.last == index ? .clear : StaticStore.pastelColors[index])
                                                .frame(width: (screenWidth-8)/3.25, height: 140)
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
                                            .frame(height: 160)
                                            .offset(vm.getOffset(option, width: screenWidth / 16, height: screenHeight/12))
                                            .scaleEffect(vm.isSelected(option) && !vm.isFirstFalseAnswer(option) ? 5 : 1)
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
                } // if statement
            } //VStack
            .navigationBarBackButtonHidden(true)
            .background {
                LinearGradient(
                    gradient: Gradient(colors: [.skyWhisperColor, .cherryMilkColor]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ).ignoresSafeArea()
            }
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
    WhosePartIsThisView()
        .environmentObject(AudioManager.shared)
    
}
