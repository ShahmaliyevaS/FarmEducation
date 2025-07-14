//
//  testview.swift
//  FarmEducation
//
//  Created by Sevinj Shahmaliyeva on 04.07.25.
//

import SwiftUI

struct TapPoint: Identifiable {
    let id = UUID()
    let location: CGPoint
}

struct testview: View {
    
    @State var points: [CGPoint] = [CGPoint.zero]
        @State var dragLocation: CGPoint?
        @State var tapLocation: CGPoint?
        
        var body: some View {
            let tapDetector = TapGesture()
                .onEnded {
                    tapLocation = dragLocation
                    guard let point = tapLocation else {
                        return
                    }
                    points.append(point)
                }
            
            let dragGesture = DragGesture(minimumDistance: 0, coordinateSpace: .global)
                .onChanged { value in
                    self.dragLocation = value.location
                }
            
            ZStack { //< Here
                ForEach(points, id: \.x) {point in
                    CreateCircle(location: point)
                }
            }
            .background(Color.black
                            .scaledToFill())
            .ignoresSafeArea()
            .gesture(dragGesture.sequenced(before: tapDetector)) //<-- Here
        }
}

struct CreateCircle: View {
    

    @State private var currentLocation: CGPoint = CGPoint(x: 100, y: 100)
    
    init(location: CGPoint) {
        currentLocation = location
    }
    
    var body: some View {

        return Circle().fill(Color.red)
            .frame(width: 50, height: 50)
            .position(currentLocation)
    }
}

#Preview {
    testview()
}
