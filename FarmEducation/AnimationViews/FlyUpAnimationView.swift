//
//  BalloonAnimationView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 05.06.25.
//

import SwiftUI

struct FlyUpAnimationView: View {
    var score:String = ""
    @State var animation: Bool = false
    @State var isHidden: Bool = false
    var ballons = ["ballon-blue", "ballon-green", "ballon-orange", "ballon-pink", "ballon-purple", "ballon-red", "ballon-yellow"]
    
    var body: some View {
        GeometryReader { geo in
            let screenHeight = geo.size.height
            let balloonSizes = (0...6).map { _ in CGFloat(Int.random(in: 50...200)) }
            let balloonOffsetsX = (0...6).map { _ in  CGFloat.random(in: -250...200)}
            let balloonOffsetsY = (0...6).map { _ in CGFloat.random(in: -400...100)}
            
            ZStack {
                Color.clear
                ForEach(0..<ballons.count-1, id: \.self) { i in
                    Image(ballons[i])
                        .resizable()
                        .scaledToFit()
                        .overlay{
                            Text(score)
                                .fontWeight(.bold)
                                .font(.largeTitle)
                                .foregroundStyle(.blue.opacity(0.5))
                                .padding(.bottom, 50)
                        }
                        .frame(width: balloonSizes[i])
                        .offset(x: balloonOffsetsX[i], y: animation ? balloonOffsetsY[i] : screenHeight/1.4)
                        .opacity(isHidden ? 0 : 1)
                        .animation(.easeInOut(duration: TimeInterval(Int.random(in: 5...15))), value: animation)
                        .animation(.easeInOut(duration: TimeInterval(Int.random(in: 10...15))), value: isHidden)
                }
            }
            .onAppear{
                animation.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isHidden.toggle()
                }
                
            }
        }
    }
    
}

#Preview {
    FlyUpAnimationView()
}
