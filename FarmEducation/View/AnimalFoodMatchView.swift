//
//  AnimalFoodMatchView.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 19.05.25.
//

import SwiftUI

struct AnimalFoodMatchView: View {
    var body: some View {
        
            VStack {
                GeometryReader { geo in
                    ZStack (alignment: .topLeading) {
                        Image("farmBackground")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width / 0.7)
                            .overlay {
                                LinearGradient(
                                    stops: [
                                        .init(color: .clear, location: 0),
                                        .init(color: .green, location: 1)
                                    ],
                                    startPoint: .center,
                                    endPoint: .bottom
                                )
                            }
                            Image("cow")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 700)
                                .frame(maxHeight: 400)
                                .shadow(radius: 10)
                            .offset(x: -150, y: 140)
                    }
                    .ignoresSafeArea()
                }
                Spacer()
                
                Text("Rabbit")
                    .font(.custom("ChalkboardSE-Regular", size: 28))
                    .bold()
                    .foregroundStyle(.gray)
                    
                HStack(spacing: 20) {
                    OptionButtonView(backgroundColor: .pink, cornerColor: .blue, option: "milk")
                    
                    OptionButtonView(backgroundColor: .green, cornerColor: .orange, option: "carrot")
                    
                    OptionButtonView(backgroundColor: .yellow, cornerColor: .blue, option: "egg")
                    
                } //HStack
                .padding()
            .ignoresSafeArea()
                
        } //GeometryReader
        .background{
            Color.green
                .ignoresSafeArea()
        }
       
    }
}

#Preview {
    AnimalFoodMatchView()
}
