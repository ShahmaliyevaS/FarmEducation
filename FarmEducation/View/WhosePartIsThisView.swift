//
//  WhoseTailIsThisView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 16.07.25.
//

import SwiftUI

struct WhosePartIsThisView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var firstFalseAnswer: String = ""
    @State var answer: String = ""
    @State var disabledAnswers: Set<Int> = []
    @State var offsetAnimation = false
    @State var questionImageAnimation = false
    @State var isHidden = false
    @State var correctAnswersCount = 0
    @State var selectedParts: [Int] = [4]
    @StateObject var viewModel = QuestionViewModel()
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 0), count: 3)
    var gameType: GameType = .whosePartIsThis
    var data = Array(repeating: "", count: 9)
    
    var body: some View {
        ZStack {
            VStack {
                if let round = viewModel.currentRound {
                    GeometryReader { geo in
                        let screenWidth = geo.size.width
                        let screenHeight = geo.size.height
                        ZStack (alignment: .topLeading) {
                            VStack {
                                HStack {
                                    Button {
                                        saveScore()
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
                                        .animation(.snappy, value: questionImageAnimation)
                                        .opacity(isHidden ? 0 : 1)
                                        .animation(.smooth(duration: TimeInterval(0.8)), value: isHidden)
                                    
                                    LazyVGrid(columns: columns, spacing: 0) {
                                        ForEach(Array(data.enumerated()), id: \.offset) { index, item in
                                            Rectangle()
                                                .fill(selectedParts.last == index ? .clear : StaticStore.pastelColors[index])
                                                .frame(width: (screenWidth-8)/3.25, height: 160)
                                                .border(Color.lavenderBlueColor)
                                                .animation(.smooth, value: selectedParts.last != index)
                                                .onTapGesture {
                                                    if selectedParts.count == 1 && selectedParts.last != index {
                                                        selectedParts.append(index)
                                                    }
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
                                Text(gameType.title)
                                    .chalkboardFont(size: 28)
                                    .bold()
                                    .foregroundStyle(Color.lavenderBlueColor)
                                    .animation(.spring, value: questionImageAnimation)
                                    .padding(.bottom, 32)
                                
                                HStack(spacing: 20) {
                                    ForEach(0..<round.options.count, id: \.self) { i in
                                        let option = round.options[i]
                                        let size = screenWidth / 16
                                        let image = answer == option && answer != round.correctAnswer
                                        ? Constants.falseImage : option
                                        let cornerColor =  answer == option ? Color.clear : .lavenderBlueColor
                                        let centerOffset = i == 0 ? size : (i == 1 ? 0 : -size)
                                        OptionButtonView(
                                            backgroundColor: .clear ,
                                            cornerColor: cornerColor,
                                            image: image,
                                            shadow: answer == option ? false : true
                                        )
                                        .frame(height: 160)
                                        .offset(x: answer == option ? centerOffset : 0,
                                                y: answer == option ? -screenHeight/12 : 0)
                                        .scaleEffect(answer == option ? 5 : 1)
                                        .animation(.smooth, value: offsetAnimation)
                                        .overlay {
                                            if firstFalseAnswer == option {
                                                Image(Constants.falseImage)
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
                                                    answer = option
                                                    offsetAnimation.toggle()
                                                    
                                                    let filtered = (0...2).filter { $0 != i }
                                                    for item in filtered {
                                                        disabledAnswers.insert(item)
                                                    }
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                                        firstFalseAnswer = ""
                                                        isHidden = false
                                                        answer = ""
                                                        disabledAnswers = []
                                                        offsetAnimation.toggle()
                                                        questionImageAnimation.toggle()
                                                        viewModel.loadNextQuestion()
                                                        selectedParts = [4]
                                                    }
                                                }
                                            }
                                            if option == round.correctAnswer {
                                                isHidden = true
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
    WhosePartIsThisView()
}
