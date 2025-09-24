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
    @StateObject var vm = WhoIsMyPairViewModel(.whoIsMyPair, AudioManager.shared)
    
    let gameType: GameType = .whoIsMyPair
    let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)
    
    var body: some View {
        ZStack {
            VStack {
                if !vm.currentRound.isEmpty {
                    GeometryReader { geo in
                        let screenWidth = geo.size.width
                        let screenHeight = geo.size.height
                        
                        ZStack(alignment: .topLeading) {
                            HStack {
                                Button {
                                    ScoreManager.shared.saveScore(
                                        gameType,
                                        askedQuestionsCount: vm.allAnswers,
                                        correctAnswersCount: vm.correctAnswers
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
                                    ForEach(Array(vm.currentRound.enumerated()), id: \.offset) {index, option in
                                        OptionButtonView(design: vm.getOptionView(index, option))
                                            .frame(height: (geo.size.height - 120)/5)
                                            .rotation3DEffect(
                                                .degrees(vm.getDegress(vm.isSelected(index))),
                                                axis: (x: 0, y: 1, z: 0)
                                            )
                                            .animation(.smooth, value: vm.isSelected(index))
                                            .rotation3DEffect(
                                                .degrees(vm.getDegress(vm.newGame)),
                                                axis: (x: 0, y: 1, z: 0)
                                            )
                                            .animation(.smooth, value: vm.newGame)
                                            .onTapGesture {
                                                vm.selectImage(at: index)
                                            }
                                    }
                                }
                                .padding(.horizontal)
                                
                                Button {
                                    vm.playNewGame()
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
                    } //GeometryReaderaudio.
                    .ignoresSafeArea()
                }  //if statement
            } //VStack
            
            if vm.correctAnswers == 6 {
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
    }
}

#Preview {
    WhoIsMyPairView()
        .environmentObject(AudioManager.shared)
    
}
