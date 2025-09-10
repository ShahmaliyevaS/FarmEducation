//
//  GameProgressView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 08.09.25.
//

import SwiftUI

struct GameProgressView: View {
    @State var vegetables = StaticStore.vegetables
    @State var progressArray: [Int] = []
    @State var go = true
    
    @Binding var correctAnswers: Int
    
    @State var progressValue: Int = 0
    @State var scaleEffectValue = 1
    @State var offSetValue = -40
    
    var body: some View {
        ZStack(alignment: .leading) {
            HStack {
                ForEach(0..<10) { i in
                    Image(vegetables[i])
                        .resizable()
                        .scaledToFit()
                        .frame(height: 25)
                        .opacity(progressArray.contains(i) ? 0 : 1)
                }
            }
            .padding(.horizontal)
            .frame(width: 300)
            
            Image(Constants.UI.tractor)
                .resizable()
                .scaledToFit()
                .frame(height: 50)
                .scaleEffect(x: CGFloat(scaleEffectValue), y: 1, anchor: .center)
                .offset(x: CGFloat(offSetValue), y: -10)
        }
        .frame(width: 325)
        .padding(.bottom)
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
            vegetables.shuffle()
        } else if progressArray.count == 1 {
            scaleEffectValue = 1
        }
        
        if progressArray.count == 10 {
            go = false
        } else if progressArray.count == 0 {
            go = true
        }
        
        if go {
            offSetValue += 25
            progressArray.append(progressValue-1)
        } else {
            offSetValue -= 25
            progressArray.removeLast()
        }
    }
}

struct GameProgressView_Previews: PreviewProvider {
    @State static var answers: Int = 15
    static var previews: some View {
        GameProgressView(correctAnswers: $answers)
    }
}
