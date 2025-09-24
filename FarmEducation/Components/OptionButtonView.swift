//
//  OptionButtonView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 19.05.25.
//

import SwiftUI

struct OptionButtonView: View {
    var design: OptionButtonDesign
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 44)
                .fill(design.backgroundColor)
                .stroke(design.cornerColor, lineWidth: 4)
            
            if let option = design.image {
                VStack {
                    Image(option)
                        .resizable()
                        .scaledToFit()
                        .padding(.all, 20)
                }
            }
        }
        .shadow(color: design.shadow ? .black.opacity(0.5) : .clear, radius: 10, x: 5, y: 5)
    }
}

#Preview {
    OptionButtonView(design: OptionButtonDesign(backgroundColor: .orange, cornerColor: .red , image: Constants.Meal.egg))
        .frame(width: 120)
}
