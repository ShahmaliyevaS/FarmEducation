//
//  GameProgressView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 08.09.25.
//

import SwiftUI

struct GameProgressView: View {
    var gameType :GameType
    @State var data: [String] = []
    @State var car: String = ""
    @State var progressArray: [Int] = []
    @State var go = true
    
    @Binding var correctAnswers: Int
    
    @State var progressValue: Int = 0
    @State var scaleEffectValue = 1
    @State var offSetValue = -40
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                if data.count > 0 {
                    ForEach(0..<10) { i in
                        Image(data[i])
                            .resizable()
                            .scaledToFit()
                            .frame(height: 25)
                            .opacity(progressArray.contains(i) ? 0 : 1)
                            .colorMultiply(gameType.rawValue == GameType.whichAnimalsShadow.rawValue ? .black : .white )
                    }
                }
            }
            .padding(.horizontal)
            .frame(width: 300)
            
            Image(gameType.carDesign)
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .scaleEffect(x: CGFloat(scaleEffectValue), y: 1, anchor: .center)
                .offset(x: CGFloat(offSetValue), y: -10)
        }
        .frame(width: 325)
        .padding(.bottom)
        .onAppear {
            data = gameType.progressDesign
        }
        .onChange(of: correctAnswers) {
            updateProgress()
        }
    }
    
    private func updateProgress() {
        if correctAnswers <= 10 {
            progressValue = correctAnswers
        } else if correctAnswers % 10 == 0 {
            progressValue = 10
        } else {
            progressValue = correctAnswers % 10
        }
        
        if progressArray.count == 9 {
            scaleEffectValue = -1
        } else if progressArray.count == 1 {
            scaleEffectValue = 1
        }
        
        if progressArray.count == 10 {
            data.shuffle()
            go = false
        } else if progressArray.count == 0 {
            go = true
        }
        
        if go {
            offSetValue += 27
            progressArray.append(progressValue-1)
        } else {
            offSetValue -= 27
            progressArray.removeLast()
        }
    }
}

struct GameProgressView_Previews: PreviewProvider {
    @State static var answers: Int = 15
    static var previews: some View {
        GameProgressView(gameType: .whatAnimalsEat, correctAnswers: $answers)
    }
}
