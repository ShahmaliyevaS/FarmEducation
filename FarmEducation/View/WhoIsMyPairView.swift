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
        GeometryReader { geo in
            let screenHeight = geo.size.height
            if !vm.currentRound.isEmpty {
                VStack {
                    HStack {
                        Button {
                            vm.exitGame(dismiss: { dismiss() }, gameType: gameType)
                        } label: {
                            ExitView()
                                .frame(height: screenHeight/15)
                        }
                        Spacer()
                    } // Exit button
                    .padding(.top, 24)
                    .padding(.leading, 8)
                    Spacer()
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(Array(vm.currentRound.enumerated()), id: \.offset) {index, option in
                            OptionButtonView(design: getOptionView(index, option))
                                .frame(height: max(0, (geo.size.height - 120)/5))
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
                    Spacer()
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
                    
                    Spacer()
                } //VStack
                .navigationBarBackButtonHidden(true)
                .background{
                    LinearGradient(
                        gradient: Gradient(colors: [.skyWhisperColor, .cherryMilkColor]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                }
            }  //if statement
            if vm.correctAnswers == 6 {
                AnimationManager(score: Int.random(in: 1...6) * 10)
            }
        } //GeometryReaderaudio
        .ignoresSafeArea()
    }
    
    func getOptionView(_ index: Int, _ option: String) -> OptionButtonDesign {
        if !vm.correctImages.contains(index) {
            return OptionButtonDesign( backgroundColor: StaticStore.pastelColors.randomElement()!, cornerColor: Color.lavenderBlueColor, image: !vm.isSelected(index) ? nil : option)
        }
        return OptionButtonDesign(backgroundColor: .clear, cornerColor: .clear, shadow: false)
    }
}

#Preview {
    WhoIsMyPairView()
        .environmentObject(AudioManager.shared)
    
}
