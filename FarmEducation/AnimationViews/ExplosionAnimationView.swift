//
//  ExplosionAnimationView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 19.06.25.
//

import SwiftUI

struct ExplosionAnimationView: View {
    @State var up = false
    @State var down = false
    var array = Array(-250...450)
    
    var body: some View {
        ZStack {
            ForEach(0...100, id: \.self) { i in
                Image(StaticStore.candies.randomElement() ?? StaticStore.flowers[0])
                    .resizable()
                    .foregroundColor(Color.customRandom)
                    .frame(width: 52, height: 52)
                    .rotationEffect(.degrees(Double.random(in: 10...300)))
                    .offset(x: up ? CGFloat(array[i*5]) : 0,
                            y: down ? CGFloat(Int.random(in: 450 ... 500)) :
                                ( up ? CGFloat(Int.random(in: -500 ... -100)) : 450 ))
                    .opacity(down ? 0 : 1)
                    .animation(.easeOut(duration: 2), value: up)
                    .animation(.smooth(duration: TimeInterval(Int.random(in: 4...10))), value: down)
                    .transition(.scale)
            }
        }
        .onAppear{
            up.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                playSoundWav(name: Constants.UI.woow2)
                playNotificationHaptic(type: .error)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                down.toggle()
            }
        }
    }
}

#Preview {
    ExplosionAnimationView()
}
