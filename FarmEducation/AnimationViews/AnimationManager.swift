//
//  AnimationManager.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 14.08.25.
//

import SwiftUI

struct AnimationManager: View {
    var score: Int
    
    var body: some View {
        if score > 9 {
            if score % 60 == 0 {
                TwirlingDropAnimationView(data: StaticStore.flowers)
            } else if score % 50 == 0 {
                FireWorksAnimationView()
            } else if score % 40 == 0 {
                TwirlingDropAnimationView(data: StaticStore.candies)
            } else if score % 30 == 0 {
                FlyUpAnimationView(data: StaticStore.flowers)
            } else if score % 20 == 0 {
                TwirlingDropAnimationView(data: StaticStore.cakes)
            } else if score % 10 == 0 {
                FlyUpAnimationView(data: StaticStore.balloons)
            }
        }
    }
}

#Preview {
    AnimationManager(score: 10)
        .environmentObject(AudioManager.shared)
}
