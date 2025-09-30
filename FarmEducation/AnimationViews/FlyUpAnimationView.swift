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
    var data: [String] = []
    
    var body: some View {
        GeometryReader { geo in
            let screenHeight = geo.size.height
            let screenWidth = geo.size.width
            let item: [ImageLayout] = data.map {
                ImageLayout(image: $0,
                            size: CGFloat(Int.random(in: 50...120)),
                            offsetX: CGFloat.random(in: -screenWidth...screenWidth),
                            offsetY: CGFloat.random(in: -screenHeight...screenHeight))}
            ZStack {
                Color.clear
                ForEach(0..<item.count, id: \.self) { i in
                    Image(item[i].image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: item[i].size)
                        .offset(x: item[i].offsetX, y: animation ? item[i].offsetY! : screenHeight/1.4)
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
    FlyUpAnimationView(data: StaticStore.balloons)
        .environmentObject(AudioManager.shared)
}
