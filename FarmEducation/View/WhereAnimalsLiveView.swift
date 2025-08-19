//
//  WhereAnimalsLive.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 11.07.25.
//

import SwiftUI

struct WhereAnimalsLiveView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var firstFalseAnswer: String = ""
    @State var answer: String = ""
    @State var disabledAnswers: Set<Int> = []
    @State var offsetAnimation = false
    @State var questionImageAnimation = false
    @State var correctAnswersCount = 0
    @StateObject var viewModel = QuestionViewModel()
    
    var gameType: GameType = .whereAnimalsLive
    
    var body: some View {
        ZStack {
            VStack {
                if let round = viewModel.currentRound {
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
                                Text(NSLocalizedString(gameType.rawValue, comment: ""))
                                    .chalkboardFont(size: 20)
                                    .bold()
                                    .foregroundStyle(Color.burntOrangeColor)
                                    .animation(.spring, value: questionImageAnimation)
                                    .padding(.bottom, 32)
                                HStack(spacing: 20) {
                                    ForEach(0..<round.options.count, id: \.self) { i in
                                        let option = round.options[i]
                                        let size = screenWidth / 12
                                        let image = answer == option && answer != round.correctAnswer ? Constants.UI.falseImage : option
                                        let backgroundColor = Color.clear
                                        let cornerColor =  answer == option ? Color.clear : .burntOrangeColor
                                        let centerOffset = i == 0 ? size : (i == 1 ? 0 : -size)
                                        OptionButtonView(backgroundColor:  backgroundColor ,
                                                         cornerColor: cornerColor,
                                                         image: image,
                                                         shadow: answer == option ? false : true
                                        )
                                        .frame(height: 160)
                                        .offset(x: answer == option ? centerOffset : 0,
                                                y: answer == option ? -screenHeight/10 : 0)
                                        .animation(.smooth, value: offsetAnimation)
                                        .overlay {
                                            if firstFalseAnswer == option {
                                                Image(Constants.UI.falseImage)
                                                    .resizable()
                                                    .scaledToFit()
                                            }
                                        }
                                        .scaleEffect(answer == option ? 4 : 1)
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
                                                playSoundWav(name: Constants.UI.correct)
                                                playNotificationHaptic(type: .success)
                                            } else {
                                                playSoundWav(name: Constants.UI.error)
                                                playNotificationHaptic(type: .error)
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
                        .background{
                            Places(rawValue: round.question)?.backgroundColor ??
                            Color.greenNeonGrassColor
                            
                        }
                    } //GeometryReader
                    .ignoresSafeArea()
                } // end of if statement
            } //VStack
            .navigationBarBackButtonHidden(true)
            .onAppear {
                viewModel.loadQuestions(for: gameType)
            }
            AnimationManager(score: correctAnswersCount)
        } //ZStack
    }
}

#Preview {
    WhereAnimalsLiveView()
}
