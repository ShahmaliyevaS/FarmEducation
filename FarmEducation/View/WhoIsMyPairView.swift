//
//  WhoIsMyPairView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 17.07.25.
//

import SwiftUI

struct WhoIsMyPairView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject var viewModel = WhoIsMyPairViewModel()
    @State var data1 : [String]?
    @State var i = 0
    @State var selectedImages: [Int] = []
    @State var correctImages: [Int] = []
    @State var allAnswers: Int = 0
    @State var correctAnswers: Int = 0
    @State var newGame = false
    let gameType: GameType = .whoIsMyPair
    let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)
    
    var body: some View {
        ZStack {
            VStack {
                if let data = data1 {
                    GeometryReader { geo in
                        let screenWidth = geo.size.width
                        let screenHeight = geo.size.height
                        ZStack (alignment: .topLeading) {
                            HStack {
                                Button {
                                    ScoreManager.score.saveScore(gameType, askedQuestionsCount: allAnswers, correctAnswersCount: correctAnswers)
                                    dismiss()
                                } label: {
                                    ExitView()
                                }
                                Spacer()
                            } // Exit button
                            .offset(CGSize(width: 0, height: 40))
                            .frame(width: (geo.size.width.isNaN || geo.size.width < 32) ? 0 : geo.size.width - 32)
                            .padding(.horizontal)
                            
                            VStack {
                                LazyVGrid(columns: columns, spacing: 20) {
                                    ForEach(Array(data.enumerated()), id: \.offset) { index, item in
                                        if !correctImages.contains(index) {
                                            OptionButtonView(
                                                backgroundColor: StaticStore.pastelColors.randomElement()!,
                                                cornerColor: .lavenderBlueColor,
                                                image: !selectedImages.contains(index) ? nil : item
                                            )
                                            .frame(height: (geo.size.height - 120)/5)
                                            .rotation3DEffect(
                                                .degrees(selectedImages.contains(index) ? 180 : 0),
                                                axis: (x: 0, y: 1, z: 0)
                                            )
                                            .animation(.smooth, value: selectedImages.contains(index))
                                            .rotation3DEffect(
                                                .degrees(newGame ? 180 : 0),
                                                axis: (x: 0, y: 1, z: 0)
                                            )
                                            .animation(.smooth, value: newGame)
                                            .onTapGesture {
                                                if !selectedImages.contains(index) && selectedImages.count != 2 {
                                                    if selectedImages.count <= 1 {
                                                        selectedImages.append(index)
                                                    }
                                                    
                                                    if selectedImages.count == 2 {
                                                        allAnswers += 1
                                                        if data[selectedImages[0]] == data[selectedImages[1]] {
                                                            playSoundWav(name: Constants.UI.correct)
                                                            playNotificationHaptic(type: .success)
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                                                correctImages += selectedImages
                                                                correctAnswers += 1
                                                            }
                                                        } else {
                                                            playSoundWav(name: Constants.UI.error)
                                                            playNotificationHaptic(type: .error)
                                                        }
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                            selectedImages = []
                                                        }
                                                    }
                                                }
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
                                    ScoreManager.score.saveScore(gameType, askedQuestionsCount: allAnswers, correctAnswersCount: correctAnswers)
                                    correctAnswers = 0
                                    allAnswers = 0
                                    selectedImages = []
                                    correctImages = []
                                    viewModel.loadNextQuestion()
                                    data1 = viewModel.currentRound
                                    newGame.toggle()
                                    playSoundWav(name: Constants.UI.cards)
                                    playNotificationHaptic(type: .error)
                                } label: {
                                    Text(NSLocalizedString(Constants.UI.newGame, comment: ""))
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
                }  // end of if statement
            } //VStack
            if correctAnswers == 6 {
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
            data1 = viewModel.currentRound ?? Array(repeating: "", count: 12)
        }
    } //ZStack
}

#Preview {
    WhoIsMyPairView()
}
