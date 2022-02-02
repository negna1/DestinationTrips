//
//  ProgressIndicator.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 12.01.22.
//

import SwiftUI

struct ProgressIndicator: View {
    var percent: CGFloat
    private let gradient = LinearGradient.init(colors: [.red, .indigo], startPoint: .leading, endPoint: .trailing)
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.canvas, lineWidth: 10)
                .frame(width: 200, height: 200, alignment: .center)
            Circle()
                .trim(from: 0, to: percent)
                
                .stroke(gradient, lineWidth: 10)
                .frame(width: 200, height: 200, alignment: .center)
                .overlay(Text((percent * 100).description + " %")
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                )
        }
    }
}

struct ProgressIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ProgressIndicator(percent: 0.9)
    }
}
