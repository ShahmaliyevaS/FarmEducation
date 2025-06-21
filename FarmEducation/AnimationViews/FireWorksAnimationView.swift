//
//  FireWorksAnimationView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 18.06.25.
//

import SwiftUI

struct Firework: Identifiable {
    let id = UUID()
}

struct FireWorksAnimationView: View {
    
    @State private var fireworks: [Firework] = []
    @State private var fireCount = 0
    let maxCount = 10
    
    var body: some View {
        ZStack {
            ForEach(fireworks) { firework in
                FireWorksComponentAnimationView()
                    .id(firework.id)
                    .offset(x: CGFloat(Int.random(in: -200...200)), y: CGFloat(Int.random(in: -200...200)))
                    .transition(.scale)
            }
        }
        .onAppear {
            startFireworks()
        }
    }
    
    func startFireworks() {
        guard fireCount < maxCount else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation {
                fireworks.append(Firework())
                fireCount += 1
            }
            startFireworks()
        }
    }
}
#Preview {
    ZStack {
        Color.blue
        FireWorksAnimationView()
    }
    .edgesIgnoringSafeArea(.all)
}
