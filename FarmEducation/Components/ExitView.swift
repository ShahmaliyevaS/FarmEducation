//
//  ExitView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 12.08.25.
//

import SwiftUI

struct ExitView: View {
    var body: some View {
        Image(Constants.smallCould)
            .resizable()
            .scaledToFit()
            .opacity(0.8)
            .frame(height: 50)
            .shadow(color: Color.lavenderBlueColor.opacity(0.6), radius: 10, x: 5, y: 5)
            .overlay(
                HStack(spacing: 1) {
                    Image(systemName: Constants.turnUp)
                    Text(Constants.exit).bold()
                }
                    .chalkboardFont(size: 16)
                    .foregroundStyle(Color.skyBlueColor.opacity(0.7))
                    .offset(y: 4)
            )
    }
}

#Preview {
    ExitView()
}
