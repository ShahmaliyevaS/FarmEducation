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
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 44)
                 .fill(backgroundColor)
                 .stroke(cornerColor, lineWidth: 5)
                 .frame(height: 160)
            
            VStack {
                Image(option)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .padding(.horizontal)
                    .padding(.top)
                
                Text(option.capitalized)
                    .font(.custom("ChalkboardSE-Regular", size: 20))
                    .foregroundStyle(cornerColor)
                    .bold()
                    .padding(.bottom)
            }
        }
        .shadow(color: .black.opacity(0.5), radius: 10, x: 5, y: 5)
    }
}

#Preview {
    OptionButtonView(backgroundColor: .orange, cornerColor: .brown , option: "egg")
        .frame(width: 120)
}
