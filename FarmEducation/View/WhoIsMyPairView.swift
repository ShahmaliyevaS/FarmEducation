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
    @State var balance: Int = 0
    
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
                                            .onTapGesture {
                                                if !selectedImages.contains(index) {
                                                    if selectedImages.count <= 1 {
                                                        selectedImages.append(index)
                                                    }
                                                    
                                                    if selectedImages.count == 2 {
                                                        if data[selectedImages[0]] == data[selectedImages[1]] {
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                                                correctImages += selectedImages
                                                                balance += 10
                                                            }
                                                        } else  {
                                                            balance -= 5
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
                                            .frame(height: (geo.size.height - 120)/5)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                
                                Button {
                                    print(balance)
                                    viewModel.loadNextQuestion()
                                    data1 = viewModel.currentRound
                                    correctImages = []
                                } label: {
                                    Text(Constants.newGame)
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
                }
            } // end of if statement
        } //VStack
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


struct testView: View {
    
    var backgroundColor: Color
    var cornerColor: Color
    var image: String?
    var shadow: Bool = true
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 44)
                .fill(backgroundColor)
                .stroke(cornerColor, lineWidth: 4)
//                .frame(height: 160)
            
            if let option = image {
                VStack {
                    Image(option)
                        .resizable()
                        .scaledToFit()
//                        .frame(height: 100)
                        .padding(.horizontal, 20)
                }
            }
        }
        .shadow(color: shadow ? .black.opacity(0.5) : .clear, radius: 10, x: 5, y: 5)
    }
}
