//
//  WhoseTailIsThisView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 16.07.25.
//

import SwiftUI

struct WhoseTailIsThisView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var firstFalseAnswer: String = ""
    @State var answer: String = ""
    @State var disabledAnswers: Set<Int> = []
    @State var offsetAnimation = false
    @State var questionImageAnimation = false
    @State var correctAnswersCount = 0
    @State var isHidden = false
    @StateObject var viewModel = QuestionViewModel()
    
    var gameType: GameType = .whichAnimalsShadow
    
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
                                    Image(round.question)
                                        .resizable()
                                        .scaledToFit()
                                        .scaledToFill()
                                        .frame(height: screenHeight/2.2)
                                        .shadow(radius: 10)
                                        .opacity(isHidden ? 0 : 1)
                                        .animation(.snappy, value: questionImageAnimation)
                                        .animation(.smooth(duration: TimeInterval(1.8)), value: isHidden)
                                    Image("hay")
                                        .resizable()
                                        .scaledToFit()
                                        .scaleEffect(x: -1.2, y: 2)
                                        .offset(x: -140, y: -150)
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
                                        let size = screenWidth / 16
                                        let image = answer == option && answer != round.correctAnswer ? "falseImage" : option
                                        let backgroundColor = answer == option ? Color.clear : .sunGlowColor
                                        let cornerColor =  answer == option ? Color.clear : .burntOrangeColor
                                        let centerOffset = i == 0 ? size : (i == 1 ? 0 : -size)
                                        OptionButtonView(backgroundColor:  backgroundColor ,
                                                         cornerColor: cornerColor,
                                                         image: image,
                                                         shadow: answer == option ? false : true
                                        )
                                        .offset(x: answer == option ? centerOffset : 0,
                                                y: answer == option ? -screenHeight/12 : 0)
                                        .scaleEffect(answer == option ? 5 : 1)
                                        .animation(.smooth, value: offsetAnimation)
                                        .overlay {
                                            if firstFalseAnswer == option {
                                                Image("falseImage")
                                                    .resizable()
                                                    .scaledToFit()
                                            }
                                        }
                                        .onTapGesture {
                                            if !disabledAnswers.contains(i) {
                                                if firstFalseAnswer.isEmpty && option != round.correctAnswer {
                                                    firstFalseAnswer = option
                                                    disabledAnswers.insert(i)
                                                } else {
                                                    isHidden = true
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
                                                        isHidden = false
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
    WhoseTailIsThisView()
}
