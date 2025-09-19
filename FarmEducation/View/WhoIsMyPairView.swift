//
//  WhoIsMyPairView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 17.07.25.
//

import SwiftUI

struct WhoIsMyPairView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var audio: AudioManager
    @StateObject var viewModel = WhoIsMyPairViewModel()
    @State var newGame = false
    
    let gameType: GameType = .whoIsMyPair
    let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)
    
    var body: some View {
        ZStack {
            VStack {
                if !viewModel.currentRound.isEmpty {
                    GeometryReader { geo in
                        let screenWidth = geo.size.width
                        let screenHeight = geo.size.height
                        
                        ZStack(alignment: .topLeading) {
                            HStack {
                                Button {
                                    ScoreManager.score.saveScore(
                                        gameType,
                                        askedQuestionsCount: viewModel.allAnswers,
                                        correctAnswersCount: viewModel.correctAnswers
                                    )
                                    dismiss()
                                } label: {
                                    ExitView()
                                }
                                Spacer()
                            } // Exit button
                            .offset(CGSize(width: 0, height: 40))
                            .frame(width: max(geo.size.width - 32, 0))
                            .padding(.horizontal)
                            
                            VStack {
                                LazyVGrid(columns: columns, spacing: 20) {
                                    ForEach(Array(viewModel.currentRound.enumerated()), id: \.offset) { index, item in
                                        if !viewModel.correctImages.contains(index) {
                                            OptionButtonView(
                                                backgroundColor: StaticStore.pastelColors.randomElement()!,
                                                cornerColor: .lavenderBlueColor,
                                                image: !viewModel.selectedImages.contains(index) ? nil : item
                                            )
                                            .frame(height: (geo.size.height - 120)/5)
                                            .rotation3DEffect(
                                                .degrees(viewModel.selectedImages.contains(index) ? 180 : 0),
                                                axis: (x: 0, y: 1, z: 0)
                                            )
                                            .animation(.smooth, value: viewModel.selectedImages.contains(index))
                                            .rotation3DEffect(
                                                .degrees(newGame ? 180 : 0),
                                                axis: (x: 0, y: 1, z: 0)
                                            )
                                            .animation(.smooth, value: newGame)
                                            .onTapGesture {
                                                viewModel.selectImage(at: index, audio: audio)
                                            }
                                        } else {
                                            OptionButtonView(
                                                backgroundColor: .clear,
                                                cornerColor: .clear
                                            )
                                            .frame(height: (geo.size.height - 120)/5)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                
                                Button {
                                    ScoreManager.score.saveScore(
                                        gameType,
                                        askedQuestionsCount: viewModel.allAnswers,
                                        correctAnswersCount: viewModel.correctAnswers
                                    )
                                    viewModel.loadNextQuestion()
                                    newGame.toggle()
                                    audio.play(name: Constants.UI.cards)
                                    playNotificationHaptic(type: .error)
                                } label: {
                                    Text(Constants.UI.newGame.localized())
                                        .fontWeight(.bold)
                                        .padding(.horizontal, 60)
                                        .padding(.vertical)
                                        .foregroundColor(Color.crystalBlueColor)
                                        .background(Color.skyWhisperColor)
                                        .cornerRadius(20)
                                }
                                .shadow(color: .lavenderBlueColor, radius: 8, y: 4)
                                .padding(.top, 20)
                            }
                            .padding(.top, 80)
                            .frame(maxWidth: screenWidth, maxHeight: screenHeight)
                        }
                    } //GeometryReader
                    .ignoresSafeArea()
                }  //if statement
            } //VStack
            
            if viewModel.correctAnswers == 6 {
                AnimationManager(score: Int.random(in: 1...6) * 10)
            }
        } //ZStack
        .navigationBarBackButtonHidden(true)
        .background{
            LinearGradient(
                gradient: Gradient(colors: [.skyWhisperColor, .cherryMilkColor]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).ignoresSafeArea()
        }
        .onAppear {
            viewModel.loadQuestions()
        }
    }
}

#Preview {
    WhoIsMyPairView()
        .environmentObject(AudioManager.shared)
    
}
