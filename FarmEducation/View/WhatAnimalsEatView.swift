//
//  WhatAnimalsEatView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 19.05.25.
//

import SwiftUI

struct WhatAnimalsEatView: View {
    
    @Environment(\.dismiss) var dismiss
    
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
                            Image("farm2")
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
                                        saveScore()
                                    } label: {
                                        Image("smallCould")
                                            .resizable()
                                            .scaledToFit()
                                            .opacity(0.8)
                                            .frame(height: 50)
                                            .shadow(color: Color.lavenderBlueColor.opacity(0.6), radius: 10, x: 5, y: 5)
                                            .overlay(
                                                HStack(spacing: 1) {
                                                    Image(systemName: "arrowshape.turn.up.backward.fill")
                                                    Text("Exit")
                                                        .bold()
                                                }
                                                    .chalkboardFont(size: 16)
                                                    .foregroundStyle(Color.skyBlueColor.opacity(0.7))
                                                    .offset(y: 4)
                                            )
                                    }
                                    Spacer()
                                } // Exit button
                                .offset(CGSize(width: 0, height: 40))
                                .frame(width: (geo.size.width.isNaN || geo.size.width < 32) ? 0 : geo.size.width - 32)
                                .padding(.horizontal)
                                
                                Spacer()
                                ZStack(alignment: .bottom) {
                                    Image("questionBackgroud")
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
                                
                                Text(round.question.capitalized)
                                    .chalkboardFont(size: 28)
                                    .bold()
                                    .foregroundStyle(Color.burntOrangeColor)
                                    .animation(.spring, value: questionImageAnimation)
                                    .padding(.bottom, 32)
                                
                                HStack(spacing: 20) {
                                    ForEach(0..<round.options.count, id: \.self) { i in
                                        let option = round.options[i]
                                        let size = screenWidth / 5.1
                                        let image = answer == option && answer == round.correctAnswer ? "rightImage" : (answer == option && answer != round.correctAnswer ? "falseImage" : option )
                                        let backgroundColor = answer == option && answer == round.correctAnswer ? Color.freshLawnColor.opacity(0.2) : (answer == option && answer != round.correctAnswer ? .brickRedColor.opacity(0.2) : .sunGlowColor)
                                        let cornerColor = answer == option && answer == round.correctAnswer ? Color.freshLawnColor : (answer == option && answer != round.correctAnswer ? .brickRedColor : .burntOrangeColor)
                                        let centerOffset = i == 0 ? size : (i == 1 ? 0 : -size)
                                        
                                        OptionButtonView(backgroundColor:  backgroundColor ,
                                                         cornerColor: cornerColor,
                                                         option: image
                                        )
                                        .offset(x: answer == option ? centerOffset : 0,
                                                y: answer == option ? -screenHeight/4 : 0)
                                        .animation(.bouncy, value: offsetAnimation)
                                        .overlay {
                                            if firstFalseAnswer == option {
                                                Image("falseImage")
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
                                            }
                                        }
                                    }
                                } //options HStack
                                .padding(.horizontal)
                                .padding(.bottom, 40)
                                .ignoresSafeArea()
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
                //onAppear
                viewModel.loadQuestions(for: gameType)
                
            }
            //            RotationAnimationView()
            //            ExplosionAnimationView()
            //            if correctAnswersCount > 0 {
            //                if correctAnswersCount % 50 == 0 {
            //                    FlyUpAnimationView(score: String(correctAnswersCount))
            //                } else if correctAnswersCount % 20 == 0 {
            //                    TwirlingDropAnimationView()
            //                } else if correctAnswersCount % 10 == 0 {
            //                    FireWorksAnimationView()
            //                }
            //            }
        } //ZStack
    }
    
    func saveScore() {
        var bestScore = 0
        var bestScoreQuestionCount = 0
        let askedQuestionsCount = viewModel.getAskedQuestionCount()
        if let score = ScoreManager.score.get(for: gameType) {
            bestScore = score.best
            bestScoreQuestionCount = score.bestCount
        }else {
            bestScore = correctAnswersCount
            bestScoreQuestionCount = askedQuestionsCount
        }
        
        if bestScore == correctAnswersCount {
            bestScoreQuestionCount = bestScoreQuestionCount < askedQuestionsCount ? bestScoreQuestionCount : askedQuestionsCount
        } else {
            bestScoreQuestionCount = bestScore>=correctAnswersCount ? bestScoreQuestionCount : askedQuestionsCount
            bestScore = bestScore>=correctAnswersCount ? bestScore : correctAnswersCount
        }
        
        let newScore = Score(recent: correctAnswersCount, recentCount: askedQuestionsCount, best: bestScore, bestCount: bestScoreQuestionCount)
        ScoreManager.score.save(newScore, for: gameType.rawValue)
        
        dismiss()
    }
}

#Preview {
    WhatAnimalsEatView()
}
