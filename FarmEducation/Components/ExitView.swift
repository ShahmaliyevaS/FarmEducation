//
//  ExitView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 12.08.25.
//

import SwiftUI

struct ExitView: View {
    var body: some View {
        Image(Constants.UI.smallCloud)
            .resizable()
            .scaledToFit()
            .shadow(color: Color.skyWhisperColor, radius: 10, x: 5, y: 5)
            .overlay(
                VStack {
                    Spacer()
                    HStack(spacing: 1) {
                        Image(systemName: Constants.UI.turnUp)
                        Text(Constants.UI.exit.localized()).bold()
                    }
                    .chalkboardFont(size: 16)
                    .foregroundStyle(Color.skyBlueColor.opacity(0.4))
                    .padding(.bottom, 4)
                }
            )
    }
}

#Preview {
    ExitView()
}
