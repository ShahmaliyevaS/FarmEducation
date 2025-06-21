//
//  FlowerAnimationView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 05.06.25.
//

import SwiftUI

struct FlowerAnimationView: View {
    @State var animation: Bool = false
    var flowers = ["flower-orang", "flower-orange", "flower-perple", "flower-pink", "flower-pinkk", "flower-yellow", "flower-orang", "flower-orange", "flower-perple", "flower-pink", "flower-pinkk", "flower-yellow"]
    
    var body: some View {
            let sizes = (0...11).map { _ in CGFloat(Int.random(in: 100...150)) }
            let offsetX = (0...11).map { _ in  CGFloat.random(in: -250...250)}
            ZStack {
                ForEach(0..<flowers.count-1, id: \.self) { i in
                    Image(flowers[i])
                        .resizable()
                        .scaledToFit()
                        .frame(width: sizes[i])
                        .offset(x: offsetX[i], y: animation ? 800 : -600)
                        .animation(.snappy(duration: TimeInterval(Int.random(in: 15...25))), value: animation)
                }
            } //ZStack
            .onAppear{
                animation.toggle()
            }
    }
}

#Preview {
    FlowerAnimationView()
}
