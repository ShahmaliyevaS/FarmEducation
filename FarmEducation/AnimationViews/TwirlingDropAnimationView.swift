//
//  TeddyAnimationView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 10.06.25.
//

import SwiftUI

struct TwirlingDropAnimationView: View {
    @State var animation: Bool = false
    var teddies = ["teddy-1", "teddy-2", "teddy-3", "teddy-4", "teddy-1", "teddy-2", "teddy-3", "teddy-4", "teddy-1", "teddy-2", "teddy-3", "teddy-4"]
    
    var candies = ["candy-1", "candy-2", "candy-3", "candy-4", "candy-5", "candy-6", "candy-7", "candy-8", "candy-9", "candy-10", "candy-11", "candy-12", "candy-13", "candy-14", "candy-15", "candy-16", "candy-17", "candy-20", "candy-21", "candy-18", "candy-19", "candy-22", "candy-23", "candy-24"]
    
    
    var body: some View {
            let sizes = (0...23).map { _ in CGFloat(Int.random(in: 40...120)) }
            let offsetX = (0...23).map { _ in  CGFloat.random(in: -250...250)}
            ZStack {
                ForEach(0..<candies.count-1, id: \.self) { i in
                    Image(candies[i])
                        .resizable()
                        .scaledToFit()
                        .frame(width: sizes[i])
                        .rotationEffect(animation ? .degrees(0) : .degrees(Double(Int.random(in: 0...270))))
                        .offset(x: offsetX[i], y: animation ? 800 : -600)
                        .animation(.snappy(duration: TimeInterval(Int.random(in: 15...25))), value: animation)
                }
            } //ZStack
            .onAppear {
                animation.toggle()
            }
    }
}

#Preview {
    TwirlingDropAnimationView()
}
