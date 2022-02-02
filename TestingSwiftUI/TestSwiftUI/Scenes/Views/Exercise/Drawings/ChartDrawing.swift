//
//  ChartDrawing.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 12.01.22.
//

import SwiftUI

struct ChartDrawing: View {
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: .init(x: 150, y: 150))
                path.addArc(center: .init(x: 150, y: 150),
                            radius: 50,
                            startAngle: .init(degrees: 0),
                            endAngle: .init(degrees: 270),
                            clockwise: false)
                
            }.fill(Color.red)
            Path { path in
                path.move(to: .init(x: 150, y: 150))
                path.addArc(center: .init(x: 150, y: 150),
                            radius: 50,
                            startAngle: .init(degrees: 0),
                            endAngle: .init(degrees: 270),
                            clockwise: true)
                
            }.fill(Color.green)
                .offset(.init(width: 5, height: -5))
            Path { path in
                path.move(to: .init(x: 150, y: 150))
                path.addArc(center: .init(x: 150, y: 150),
                            radius: 50,
                            startAngle: .init(degrees: 0),
                            endAngle: .init(degrees: 270),
                            clockwise: true)
                path.closeSubpath()
                
            }.stroke(Color.green, lineWidth: 3)
                .offset(.init(width: 5, height: -5))
        }
       
    }
}

struct ChartDrawing_Previews: PreviewProvider {
    static var previews: some View {
        ChartDrawing()
    }
}
