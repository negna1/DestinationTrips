//
//  PathExercise.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 12.01.22.
//

import SwiftUI

struct PathExercise: View {
    var body: some View {
        ZStack {
            Path { path in
                path.move(to: CGPoint(x: 20, y: 40))
               // path.addLine(to: CGPoint(x: 40, y: 40))
                path.addQuadCurve(to: CGPoint(x: 300, y: 40),
                                  control: CGPoint(x: 140, y: 0))
                
                path.addLine(to: CGPoint(x: 300, y: 40))
                path.addQuadCurve(to: CGPoint(x: 300, y: 40),
                                  control: CGPoint(x: 140, y: 0))
                
                path.addLine(to: CGPoint(x: 300, y: 100))
                path.addLine(to: CGPoint(x: 20, y: 100))
            }.fill(Color.green)
            
            Path { path in
                path.move(to: CGPoint(x: 20, y: 40))
               // path.addLine(to: CGPoint(x: 40, y: 40))
                path.addQuadCurve(to: CGPoint(x: 300, y: 40),
                                  control: CGPoint(x: 140, y: 0))
                path.addLine(to: CGPoint(x: 300, y: 40))
                
                path.addLine(to: CGPoint(x: 300, y: 100))
                path.addLine(to: CGPoint(x: 20, y: 100))
                path.closeSubpath()
            }.stroke(Color.black, lineWidth: 10)
        }
        
            
    }
}

struct PathExercise_Previews: PreviewProvider {
    static var previews: some View {
        PathExercise()
    }
}
