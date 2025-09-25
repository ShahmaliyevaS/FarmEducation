//
//  ExplosionAnimationView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 19.06.25.
//

import SwiftUI

struct ExplosionAnimationView: View {
    @EnvironmentObject var audio: AudioManager
    
    @State var up = false
    @State var down = false
    
    var body: some View {
        GeometryReader { geo in
            let screenHeight = geo.size.height
            let screenWidth = geo.size.width
            let arrayX = stride(from: -screenHeight, through: screenHeight, by: 10).map { $0 }.shuffled()

            ZStack {
                ForEach(0...100, id: \.self) { i in
                    Image(StaticStore.candies.randomElement() ?? StaticStore.flowers[0])
                        .resizable()
                        .foregroundColor(Color.customRandom)
                        .frame(width: 52, height: 52)
                        .rotationEffect(.degrees(Double.random(in: 10...300)))
                        .offset(x: up ? arrayX.randomElement()! : screenWidth/2,
                                y: down ? screenHeight+40 :
                                    ( up ? CGFloat.random(in: -screenHeight/4 ... screenHeight) : screenHeight ))
//                        .opacity(down ? 0 : 1)
                        .animation(.easeOut(duration: 2), value: up)
                        .animation(.smooth(duration: TimeInterval(Int.random(in: 4...10))), value: down)
                        .transition(.scale)
                }
            }
            .onAppear{
                up.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    audio.play(name: Constants.UI.woow2)
                    playNotificationHaptic(type: .error)
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    down.toggle()
                }
            }
        }
    }
}

#Preview {
    ExplosionAnimationView()
        .environmentObject(AudioManager.shared)
}
