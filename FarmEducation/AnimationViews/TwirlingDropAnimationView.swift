//
//  TeddyAnimationView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 10.06.25.
//

import SwiftUI

struct TwirlingDropAnimationView: View {
    @EnvironmentObject var audio: AudioManager
    
    var data: [String] = []
    @State var animation: Bool = false

    var body: some View {
        let array: [ImageLayout] = data.map {
            ImageLayout(image: $0,
                    size: CGFloat(Int.random(in: 40...80)),
                    offsetX: CGFloat.random(in: -250...250),
                    offsetY: nil)
        }
            ZStack {
                ForEach(0..<array.count-1, id: \.self) { i in
                    Image(array[i].image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: array[i].size)
                        .rotationEffect(animation ? .degrees(0) : .degrees(Double(Int.random(in: 0...270))))
                        .offset(x: array[i].offsetX, y: animation ? 800 : -600)
                        .animation(.snappy(duration: TimeInterval(Int.random(in: 15...25))), value: animation)
                }
            } //ZStack
            .onAppear {
                animation.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    audio.play(name: Constants.UI.woow1)
                    playNotificationHaptic(type: .error)
                }
            }
    }
}

#Preview {
    TwirlingDropAnimationView(data: StaticStore.cakes)
}
