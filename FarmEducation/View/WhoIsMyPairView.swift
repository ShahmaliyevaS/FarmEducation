//
//  WhoIsMyPairView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 17.07.25.
//

import SwiftUI

struct WhoIsMyPairView: View {
    @Environment(\.dismiss) var dismiss
    
        @State var correctAnswersCount = 0
    //    @StateObject var viewModel = QuestionViewModel()
    var data10 = ["cat", "cat", "cow", "cow", "dog", "dog", "pig", "pig", "sheep", "sheep", "horse", "horse" ].shuffled()
    @State var i = 0
    @State var selectedImages: [Int] = []
    @State var correctImages: [Int] = []
    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    var gameType: GameType = .whatAnimalsEat
    
    var body: some View {
        ZStack {
            VStack {
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
                        HStack {
                            Button {
                                
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
                        
                        VStack {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(Array(data10.enumerated()), id: \.offset) { index, item in
                                    if !correctImages.contains(index) {
                                        OptionButtonView(
                                            backgroundColor: .red,
                                            cornerColor: .blue,
                                            image: !selectedImages.contains(index) ? "" : item
                                        )
                                        .rotation3DEffect(
                                            .degrees(selectedImages.contains(index) ? 180 : 0),
                                            axis: (x: 0, y: 1, z: 0)
                                        )
                                        .animation(.smooth, value: selectedImages.contains(index))
                                        .onTapGesture {
                                            if !selectedImages.contains(index) {
                                                if selectedImages.count <= 1 {
                                                    selectedImages.append(index)
                                                }
                                                
                                                if selectedImages.count == 2 {
                                                    if data10[selectedImages[0]] == data10[selectedImages[1]] {
                                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                                            correctImages += selectedImages
                                                            correctAnswersCount += 1
                                                        }
                                                    }
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                        selectedImages = []
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    else {
                                        OptionButtonView(
                                            backgroundColor: .clear,
                                            cornerColor: .clear
                                        )
                                    }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .padding(6.0)
                        .padding(.top, 60)
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
            
        }
    } //ZStack
}

#Preview {
    WhoIsMyPairView()
}
