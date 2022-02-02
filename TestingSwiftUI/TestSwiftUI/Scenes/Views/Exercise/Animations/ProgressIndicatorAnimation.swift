//
//  ProgressIndicator.swift
//  TestSwiftUI
//
//  Created by Nato Egnatashvili on 12.01.22.
//

import SwiftUI

struct ProgressIndicatorAnimation: View {
    @State var progress: Double = 0
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(.systemGray5), lineWidth: 5)
                .frame(width: 80, height: 80)
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.red, lineWidth: 5)
                .frame(width: 80, height: 80)
                .rotationEffect( Angle(degrees: -90))
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 4, repeats: true) { t in
                        progress += 0.05
                        if progress >= 1 {
                            t.invalidate()
                        }
                    }
                }
                                 Text((progress * 100).description)
                .font(.caption2)
                .fontWeight(.heavy)
        }
        .animation(.linear, value: progress)
    }
}

struct ProgressIndicatorAnimation_Previews: PreviewProvider {
    static var previews: some View {
        ProgressIndicatorAnimation()
    }
}
