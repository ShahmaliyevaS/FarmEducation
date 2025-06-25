//
//  OptionButtonView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 19.05.25.
//

import SwiftUI

struct OptionButtonView: View {
    
    var backgroundColor: Color
    var cornerColor: Color
    var option: String
    var isTextVisable: Bool = true
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 44)
                .fill(backgroundColor)
                .stroke(cornerColor, lineWidth: 4)
                .frame(height: 160)
            
            VStack {
                Image(option)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.horizontal)
            }
        }
        .shadow(color: .black.opacity(0.5), radius: 10, x: 5, y: 5)
    }
}

#Preview {
    OptionButtonView(backgroundColor: .orange, cornerColor: .red , option: "egg")
        .frame(width: 120)
}
