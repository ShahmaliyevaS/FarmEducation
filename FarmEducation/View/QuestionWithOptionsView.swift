//
//  QuestionWithOptionsView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 04.07.25.
//

import SwiftUI

struct QuestionWithOptionsView: View {
    
    @Environment(\.dismiss) var dismiss
    
//    @State var firstFalseAnswer: String = ""
//    @State var answer: String = ""
//    @State var disabledAnswers: Set<Int> = []
//    @State var offsetAnimation = false
//    @State var rotationAnimation = false
//    @State var questionImageAnimation = false
//    @State var correctAnswersCount = 0
    @StateObject var viewModel = QuestionViewModel()
    
    
    
    @State var lastQuestion: QuestionRound?
    @State var newGame = false
    @State var lastGame = false
    @State var position1 = -500
    @State var position2 = 0
    @State var newQuestion: QuestionRound?
    var gameType: GameType
    
    var body: some View {
        ZStack {
            VStack {
//                if let round = viewModel.currentRound {
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
                                Spacer()
                                Spacer()
                                Spacer()
                                ZStack(alignment: .bottom) {
                                    Image("questionBackgroud")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 300)
                                        .offset(y: 10)
                                    if let last = lastQuestion {
                                        Image(last.question)
                                            .resizable()
                                            .scaledToFit()
                                            .offset(x: CGFloat(position1))
//                                            .opacity(lastGame ? 1 : 0)
                                            .frame(height: 400)
                                            .shadow(radius: 10)
                                            .animation(.easeInOut(duration: TimeInterval(5)), value: lastGame)
                                    }
                                    if let new = newQuestion {
                                        Image(new.question)
                                            .resizable()
                                            .scaledToFit()
                                            .offset(x: newGame ? 0 : 500)
                                            .frame(height: 400)
                                            .opacity(newGame ? 1 : 0)
                                            .shadow(radius: 10)
                                            .animation(.easeInOut(duration: TimeInterval(5)), value: newGame)
                                    }
                                    
                                }
                                
                                OptionButtonView(backgroundColor: .red ,cornerColor: .blue, option: "carrot")
                                    .onTapGesture {
                                        newGame = false
                                        lastGame.toggle()
                                        lastQuestion = newQuestion
                                        position1 = 0
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                           
                                            viewModel.loadNextQuestion()
                                            newQuestion = viewModel.currentRound
                                            newGame = true
                                            
                                            position1 = -500
                                            lastGame = true
                                        }
                                       
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                           
                                        }
                                       
                                        
                                    }
                                    
                                    .frame(maxWidth: screenWidth, maxHeight: screenHeight)
                            }
                        }
                        } //GeometryReader
                        .ignoresSafeArea()
//                    } // end of if statement
                } //VStack
                    .navigationBarBackButtonHidden(true)
                    .background{
                        Color.greenNeonGrassColor
                            .ignoresSafeArea()
                    }
                    .onAppear {
                        //onAppear
                        viewModel.loadQuestions(for: gameType)
                        newQuestion = viewModel.currentRound
                        lastQuestion = newQuestion
                        
                    }
            } //ZStack
        }
    }
    
    #Preview {
        QuestionWithOptionsView( gameType: .whatAnimalsEat)
    }
