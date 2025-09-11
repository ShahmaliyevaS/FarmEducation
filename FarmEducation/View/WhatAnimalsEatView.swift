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
    
    @State var firstFalseAnswer: String = ""
    @State var answer: String = ""
    @State var disabledAnswers: Set<Int> = []
    @State var offsetAnimation = false
    @State var questionImageAnimation = false
    @State var correctAnswersCount = 0
    @StateObject var viewModel = QuestionViewModel()
    
    var gameType: GameType = .whatAnimalsEat
    
    var body: some View {
        ZStack {
            VStack {
                if let round = viewModel.currentRound {
                    GeometryReader { geo in
                        let screenWidth = geo.size.width
                        let screenHeight = geo.size.height
                        ZStack (alignment: .topLeading) {
                            Image(Constants.Background.farm)
                                .resizable()
                                .scaledToFit()
                                .frame(width: geo.size.width / 0.6)
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
                                        ScoreManager.score.saveScore(gameType, askedQuestionsCount: viewModel.getAskedQuestionCount()-1, correctAnswersCount: correctAnswersCount)
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
                                ZStack(alignment: .bottom) {
                                    Image(Constants.Background.question)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 300)
                                        .offset(y: 10)
                                    Image(round.question)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 360)
                                        .shadow(radius: 10)
                                        .animation(.snappy, value: questionImageAnimation)
                                }
                                
                                Text(gameType.rawValue.localized())
                                    .chalkboardFont(size: 20)
                                    .bold()
                                    .foregroundStyle( Color.lavenderBlueColor)
                                    .animation(.spring, value: questionImageAnimation)
                                    .padding(.bottom, 32)
                                
                                HStack(spacing: 20) {
                                    ForEach(0..<round.options.count, id: \.self) { i in
                                        let option = round.options[i]
                                        let size = screenWidth / 5.1
                                        let image = answer == option && answer == round.correctAnswer ? Constants.UI.rightImage : (answer == option && answer != round.correctAnswer ? Constants.UI.falseImage : option )
                                        let backgroundColor = answer == option && answer == round.correctAnswer ? Color.freshLawnColor.opacity(0.2) : (answer == option && answer != round.correctAnswer ? .brickRedColor.opacity(0.2) : .clear)
                                        let cornerColor = answer == option && answer == round.correctAnswer ? Color.freshLawnColor : (answer == option && answer != round.correctAnswer ? .brickRedColor : .lavenderBlueColor)
                                        let centerOffset = i == 0 ? size : (i == 1 ? 0 : -size)
                                        
                                        OptionButtonView(backgroundColor:  backgroundColor ,
                                                         cornerColor: cornerColor,
                                                         image: image
                                        )
                                        .frame(height: 160)
                                        .offset(x: answer == option ? centerOffset : 0,
                                                y: answer == option ? -screenHeight/4 : 0)
                                        .animation(.bouncy, value: offsetAnimation)
                                        .overlay {
                                            if firstFalseAnswer == option {
                                                Image(Constants.UI.falseImage)
                                                    .resizable()
                                                    .scaledToFit()
                                            }
                                        }
                                        .scaleEffect(answer == option ? 1.6 : 1)
                                        .onTapGesture {
                                            if !disabledAnswers.contains(i) {
                                                if firstFalseAnswer.isEmpty && option != round.correctAnswer {
                                                    firstFalseAnswer = option
                                                    disabledAnswers.insert(i)
                                                } else {
                                                    answer = option
                                                    offsetAnimation.toggle()
                                                    
                                                    let filtered = (0...2).filter { $0 != i }
                                                    for item in filtered {
                                                        disabledAnswers.insert(item)
                                                    }
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                        firstFalseAnswer = ""
                                                        answer = ""
                                                        disabledAnswers = []
                                                        offsetAnimation.toggle()
                                                        questionImageAnimation.toggle()
                                                        viewModel.loadNextQuestion()
                                                    }
                                                }
                                            }
                                            if option == round.correctAnswer {
                                                correctAnswersCount += 1
                                                audio.play(name: Constants.UI.correct)
                                                playNotificationHaptic(type: .success)
                                            } else {
                                                audio.play(name: Constants.UI.error)
                                                playNotificationHaptic(type: .error)
                                            }
                                        }
                                    }
                                } //options HStack 
                                .padding(.horizontal)
                                .padding(.bottom, 20)
                                .ignoresSafeArea()
                                
                                GameProgressView(correctAnswers: $correctAnswersCount )
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
                viewModel.loadQuestions(for: gameType)
            }
           AnimationManager(score: correctAnswersCount)
        } //ZStack
    }
}

#Preview {
    WhatAnimalsEatView()
        .environmentObject(AudioManager.shared)
}
