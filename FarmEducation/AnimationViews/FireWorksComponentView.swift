//
//  FireWorksComponentView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 12.06.25.
//

import SwiftUI

struct FireWorksComponentView: View {
    @State private var animation = false
    var frameWidth: CGFloat = 40
    var lineWidth: CGFloat = 12
    
    var body: some View {
        ZStack {
            ForEach(0..<72, id: \.self) { i in
                let color: Color = (i % 3 == 0) ? Color.customRandom : .clear
                Circle()
                    .trim(from: CGFloat(i) / 72, to: CGFloat(i + 1) / 72)
                    .stroke(color, lineWidth: lineWidth)
                    .frame(width: animation ? frameWidth + 100 : frameWidth-20)
                    .rotationEffect(.degrees(Double(i) * (360.0 / 72)))
            }
               }
        .frame(width: frameWidth+20)
        .clipShape(Circle())
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.bouncy(duration: TimeInterval(3))) {
                    animation.toggle()
                }
            }
        }
    }
}

struct FireWorksComponentAnimationView: View {
    var fireWorks = [FireWorksComponentView(frameWidth: 40, lineWidth: 12),
                     FireWorksComponentView(frameWidth: 140,lineWidth: 24),
                     FireWorksComponentView(frameWidth: 240, lineWidth: 32)]
    
    var body: some View {
        ZStack {
            ForEach(0...Int.random(in: 0...2), id: \.self) { i  in
                if i < 2 {
                    fireWorks.randomElement() ?? fireWorks[i]
                } else {
                    fireWorks[i]
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.blue
        FireWorksComponentView()
    }
    .edgesIgnoringSafeArea(.all)
}


#Preview {
    ZStack {
        Color.blue
        FireWorksComponentAnimationView()
    }
    .edgesIgnoringSafeArea(.all)
}
