//
//  RotationAnimationView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 19.06.25.
//

import SwiftUI

struct RotationAnimationView: View {
    @State var isRotation = false
    @State var isExplosion = false
    @State var isVisable = false
    private let arrayX = Array(-250...250).shuffled()
    private let arrayY = Array(-450...450).shuffled()
    var word: String = "Bravo"
    
    var body: some View {
        ZStack {
            ForEach(0...100, id: \.self) { i in
                Text(isExplosion ? String(word.randomElement()!) : word)
                    .foregroundColor(.customRandom)
                    .font(.custom("Chalkboard SE", size: 80))
                    .rotation3DEffect(
                        .degrees(isRotation ? 0 : 90),
                        axis: (x: 0.0, y: 1.0, z: 0.0))
                    .offset(x: isExplosion ? CGFloat(arrayX[i*5]) : 0,
                            y: isExplosion ? CGFloat(arrayY[i*3]) : 0)
                    .opacity(isVisable ? 0 : 1)
                    .animation(.smooth, value: isVisable)
                    .animation(.smooth(duration: 1), value: isRotation)
                    .animation(.snappy(duration: 3), value: isExplosion)
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                isRotation.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                isExplosion.toggle()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isVisable.toggle()
            }
        }
    }
}

#Preview {
    RotationAnimationView()
}
