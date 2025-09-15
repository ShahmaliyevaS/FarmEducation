//
//  BalloonAnimationView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 05.06.25.
//

import SwiftUI

struct FlyUpAnimationView: View {
    @EnvironmentObject var audio: AudioManager
    
    @State var animation: Bool = false
    @State var isHidden: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            let screenHeight = geo.size.height
            let balloons: [ImageLayout] = StaticStore.balloons.map {
                ImageLayout(image: $0,
                            size: CGFloat(Int.random(in: 50...120)),
                            offsetX: CGFloat.random(in: -250...200),
                            offsetY: CGFloat.random(in: -400...100))}
            ZStack {
                Color.clear
                ForEach(0..<balloons.count, id: \.self) { i in
                    Image(balloons[i].image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: balloons[i].size)
                        .offset(x: balloons[i].offsetX, y: animation ? balloons[i].offsetY! : screenHeight/1.4)
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    audio.play(name: Constants.UI.woow2)
                    playNotificationHaptic(type: .error)
                }
            }
        }
    }
}

#Preview {
    FlyUpAnimationView()
        .environmentObject(AudioManager.shared)
}
