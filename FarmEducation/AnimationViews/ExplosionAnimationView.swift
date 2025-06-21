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
    @State var downOpacity = false
    var symbolsArray = ["star.fill", "heart.fill", "suit.heart", "star"]
    var array = Array(-300...300)
    var body: some View {
        ZStack {
            
            ForEach(0...200, id: \.self) { i in
                
                Image(systemName: symbolsArray.randomElement() ?? symbolsArray[0])
                    .resizable()
                    .foregroundColor(Color.customRandom)
                    .frame(width: 20, height: 20)
                    .opacity(1)
                    .rotationEffect(.degrees(down ?  Double.random(in: 10...300) : 0))
                    .offset(x: up ? CGFloat(array[i*3]) : 0,
                            y: down ? CGFloat(Int.random(in: 450 ... 500)) :
                                ( up ? CGFloat(Int.random(in: -500 ... -200)) : 450 ))
                    .animation(.easeOut(duration: 2), value: up)
                    .animation(.smooth(duration: TimeInterval(Int.random(in: 4...10))), value: down)
                    .transition(.scale)
                
            }
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                up.toggle()
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
